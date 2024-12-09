workspace "ENR2" "Enrollment System" {
    model {
        teacher = person "Teacher" "Interacts with the system to inform students about their courses and set course requirements"
        student = person "Student" "Receives information about ongoing classes and enrolls in classes."
        student_affairs_officer = person "Student Affairs Officer" "Reviews and edits enrollment-related data."

        SIS = softwareSystem "SIS" "Central system that provides data about students and taught classes, and ensures email communication." {
            web_app = container "Web Application" "Provides a user interface for accessing SIS features through a web browser." {
                tags "Web Browser"
            }
            mobile_app = container "Mobile Application" "Offers a mobile interface for SIS functionalities." {
                tags "Mobile App"
            }
            sis_app_api = container "SIS App API" "Acts as an API gateway to route requests between the front-end applications and the back-end systems." {
                tags "External Software System"
            }
            email_service = container "E-mail Service" "Handles email communication sent to users." {
                tags "Email System"
            }
        }

        ENR = softwareSystem "Enrollment module" "Handles all functionality related to class enrollment and related processes." {
            enr_controller = container "Enrollment Controller" "Central controller that routes requests and coordinates interactions between subcomponents."

            enrollment_provider = container "Course Enrollment Provider" "Handles course enrollment logic, including validation and course information retrieval." {
                enrollment_handler = component "Enrollment Handler" "Processes enrollment requests and coordinates validation and course info retrieval."
                course_info_provider = component "Course Info Provider" "Retrieves course-related information from the database."
                group "Enrollment validator" {
                   manual_validator = component "Manual Enrollment Validator" "Handles manual validation of enrollment requests."
                   automatic_validator = component "Enrollment Validator" "Performs automatic validation of enrollment conditions."
                }
            }
            enrollment_database = container "Enrollment Database" "Stores and retrieves data related to enrollments." {
                tags "Database"
            }

            statistics_provider = container "Statistics Provider" "Processes and provides analytical data and statistics for enrollment-related metrics." {
                analytical_computing = component "Analytical Computing" "Computes desired statistics from the data available in the Statistics Database."
            }
            statistics_database = container "Statistics Database" "Stores statistical data used for analysis and computation." {
                tags "Database"
            }

            messaging_provider = container "Communication Provider" "Manages notifications and messaging functionality for users." {
                message_creator = component "Message Creator" "Handles the creation of new messages." {
                    description "Handles creation of new messages."
                }
                message_editor = component "Message Editor" "Manages editing of existing messages." {
                    description "Handles editing of messages."
                }
                message_controller = component "Message Controller" "Coordinates message-related operations and routes requests to other components." {
                    description "Manages message-related operations."
                }
                message_viewer = component "Message Viewer" "Retrieves and displays messages for users." {
                    description "Handles message viewing, provides data."
                }
                message_scheduler = component "Message Scheduler" "Manages the scheduling of messages." {
                    description "Handles message scheduling."
                }
            }

            logging_provider = container "Logging provider" {
                log_manager = component "Log Manager" "Manages logs, writes and retrieves logs."
                log_local_storage = component "Local log storage" "Stores logs temporarily in a fast storage medium, such as memory."
                log_processor = component "Log processor" "Aggregates and filters logs, providing the ability to batch process them."
            }
            log_database = container "Log Database" "Serves as a long-term storage for logs, supporting retrieval and archival." {
                tags "Database"
            }
        }

        # L2_SIS
        teacher -> web_app "Interactions with SIS UI" "HTTP"
        student -> web_app "Interactions with SIS UI" "HTTP"
        student_affairs_officer -> web_app "Interactions with SIS UI" "HTTP"
        teacher -> mobile_app
        student -> mobile_app
        student_affairs_officer -> mobile_app

        web_app -> sis_app_api "Routes requests/responses" "HTTP"
        mobile_app -> sis_app_api
        email_service -> sis_app_api

        email_service -> teacher "Sends notifications" "SMTP"
        email_service -> student "Sends notifications" "SMTP"
        email_service -> student_affairs_officer "Sends notifications" "SMTP"

        # L2_ENR
        SIS -> enr_controller "Routes requests/responses" "HTTP"
        enr_controller -> enrollment_provider "Routes requests/responses" "gRPC"
        enrollment_provider -> enrollment_database "Stores/requests data" "HTTP"
        enr_controller -> statistics_provider "Routes requests/responses" "gRPC"
        statistics_provider -> statistics_database "Stores/requests data" "HTTP"
        enr_controller -> messaging_provider "Routes requests/responses" "gRPC"
        enr_controller -> logging_provider "Routes requests/responses" "gRPC"
        logging_provider -> log_database "Stores/requests data" "HTTP"

        # L3 enrollment_provider
        enr_controller -> enrollment_handler "Routes enrollment requests/responses" "gRPC"
        enrollment_handler -> sis_app_api "Routes requests/responses to SIS" "HTTP"
        enrollment_handler -> course_info_provider "Requests information about enrolled courses"
        enrollment_handler -> manual_validator "Requests manual validation of course enrolment"
        enrollment_handler -> automatic_validator "Requests automatic validation of course enrolment"
        manual_validator -> automatic_validator "Uses API of validator"
        automatic_validator -> enrollment_database "Requests data about course and student, to confirm enrollment conditions."
        course_info_provider -> enrollment_database "Requests information about course."
        course_info_provider -> sis_app_api

        # L3 statistics_provider
        enr_controller -> analytical_computing "Routes statistics requests/responses" "gRPC"
        analytical_computing -> statistics_database "Requests data for computation" "HTTP"

        # L3 messaging_provider relations
        enr_controller -> message_controller "Routes message requests/responses" "gRPC"
        sis_app_api -> enr_controller "Routes requests/responses to SIS" "HTTP"
        message_controller -> sis_app_api "Routes requests/responses to SIS" "HTTP"
        message_controller -> message_viewer "Provides message data to the viewer"
        message_controller -> message_creator "Invokes message creation"
        message_controller -> message_editor "Invokes message editing"
        message_controller -> message_scheduler "Manages scheduling of messages"

        # L3 audit_log_provider relations
        enr_controller -> log_manager "Routes log requests/responses" "gRPC"
        log_manager -> log_processor "Aggregates and filters logs"
        log_manager -> log_local_storage "Stores/retrieves logs for current processing"
        log_manager -> log_database "Stores/retrieves logs from 'cold' storage" "HTTP"

        # Deployment Environments
        deploymentEnvironment "Development" {
            deploymentNode "Kubernetes cluster - ENR Server" "" "Kubernetes" {
                deploymentNode "Enrollment controller contrainer" "" "Docker" {
                    enrControllerInstanceDev = containerInstance enr_controller
                }
                deploymentNode "Enrollment provider contrainer" "" "Docker" {
                    enrollmentProviderInstanceDev = containerInstance enrollment_provider
                }
                deploymentNode "Statistics provider contrainer" "" "Docker" {
                    statisticsProviderInstanceDev = containerInstance statistics_provider
                }
                deploymentNode "Messaging provider contrainer" "" "Docker" {
                    messagingProviderInstanceDev = containerInstance messaging_provider
                }
                deploymentNode "Logging provider contrainer" "" "Docker" {
                    loggingProviderInstanceDev = containerInstance logging_provider
                }

            }
            # Databases
            deploymentNode "Database Server" "" "PostgreSQL" {
                enrollmentDatabaseInstanceDev = containerInstance enrollment_database
                statisticsDatabaseInstanceDev = containerInstance statistics_database
            }
            deploymentNode "Kibana Server" "" "Elasticsearch" {
                logDatabaseInstanceDev = containerInstance log_database
            }
        }

        deploymentEnvironment "Production" {
            deploymentNode "Kubernetes cluster - ENR Server" "" "Kubernetes" {
                deploymentNode "Enrollment controller contrainer" "" "Docker" {
                    enrControllerInstanceProd = containerInstance enr_controller
                }
                deploymentNode "Enrollment provider contrainer" "" "Docker" {
                    enrollmentProviderInstanceProd = containerInstance enrollment_provider
                }
                deploymentNode "Statistics provider contrainer" "" "Docker" {
                    statisticsProviderInstanceProd = containerInstance statistics_provider
                }
                deploymentNode "Messaging provider contrainer" "" "Docker" {
                    messagingProviderInstanceProd = containerInstance messaging_provider
                }
                deploymentNode "Logging provider contrainer" "" "Docker" {
                    loggingProviderInstanceProd = containerInstance logging_provider
                }

            }
            # Databases
            deploymentNode "Database Database" "" "PostgreSQL" {
                enrollmentDatabaseInstanceProd = containerInstance enrollment_database
                statisticsDatabaseInstanceProd = containerInstance statistics_database
                }
                deploymentNode "Kibana Server" "" "Elasticsearch" {
                logDatabaseInstanceProd = containerInstance log_database
            }
        }
    }

    views {
        systemContext ENR "L1" {
            include SIS
            include student
            include student_affairs_officer
            include teacher
        }

        container SIS "L2_SIS" {
            include *
        }

        container ENR "L2_ENR" {
            include *
        }

        dynamic ENR {
            SIS -> enr_controller "Enrollment request"

            enr_controller -> logging_provider "Reroutes request to logger"
            logging_provider -> log_database "Stores/requests data"
            # log_database -> logging_provider "Fetched data"
            # logging_provider  -> enr_controller "Response"

            enr_controller -> messaging_provider "Routes requests to provider"
            # messaging_provider -> enr_controller "Response / Requested logs"

            enr_controller -> statistics_provider "Reroutes request to provider"
            statistics_provider -> statistics_database "Stores/requests statistics data"
            # statistics_database -> statistics_provider "Fetched data"
            # statistics_provider  -> enr_controller "Response / Requested statistics"

            enr_controller -> enrollment_provider  "Reroutes request to provider"
            enrollment_provider -> enrollment_database "Stores/requests statistics data"
            # enrollment_database -> enrollment_provider "Fetched data"
            # enrollment_provider  -> enr_controller "Response / Course info"
        }


        component enrollment_provider "L3_enrollment_provider" {
            include sis_app_api
            include enr_controller
            include enrollment_database
            include enrollment_handler
            include manual_validator
            include automatic_validator
            include course_info_provider
        }

        dynamic enrollment_provider {
            sis_app_api -> enr_controller
            enr_controller -> enrollment_handler "Request enrollment"
            enrollment_handler -> course_info_provider
            {
                {
                    course_info_provider -> sis_app_api
                    sis_app_api -> course_info_provider
                }
                {
                    course_info_provider -> enrollment_database
                    enrollment_database -> course_info_provider
                }
            }
            course_info_provider -> enrollment_handler
            enrollment_handler -> automatic_validator
            enrollment_database -> automatic_validator
            automatic_validator -> enrollment_handler
            enrollment_handler -> enr_controller
        }


        component statistics_provider "L3_statistics_provider" {
            include sis_app_api
            include enr_controller
            include analytical_computing
            include statistics_database
        }

        dynamic statistics_provider {
            enr_controller -> analytical_computing "Request statistics"
            analytical_computing -> statistics_database "Requests data for computation"
            statistics_database -> analytical_computing "Fetches data from datastore"
            analytical_computing -> enr_controller "Returns computed statistics"
        }

        component messaging_provider "L3_messaging_provider" {
            include enr_controller
            include sis_app_api
            include message_controller
            include message_creator
            include message_editor
            include message_viewer
            include message_scheduler
        }

        dynamic messaging_provider {
            sis_app_api -> enr_controller
            enr_controller -> message_controller "Request"

            message_controller -> message_creator "Option 1: Invokes message creation"
            # message_creator -> datastore_api_gateway "Option 1: Sends new messages for storage"
            message_creator -> message_controller "Option 1: Returns status info"

            message_controller -> message_editor "Option 2: Invokes message editing."
            # message_editor -> datastore_api_gateway "Option 2: Updates messages in the datastore."
            message_editor -> message_controller "Option 2: Returns status info."

            message_controller -> message_viewer "Option 4: Provides message data to the viewer"
            # message_viewer -> datastore_api_gateway "Option 4: Fetches messages for display"
            message_viewer -> message_controller "Option 4: Provides message data to the viewer"

            message_controller -> message_scheduler "Option 3: Manages scheduling of messages"
            # message_scheduler -> datastore_api_gateway "Option 3: Schedules messages via the datastore"
            message_scheduler -> message_controller "Option 3: Manages scheduling of messages"

            message_controller -> enr_controller "Response"
            enr_controller -> sis_app_api
        }

        component logging_provider "L3_logging_provider" {
            include *
        }

        dynamic logging_provider {
            enr_controller -> log_manager "Log message"
            log_manager -> log_processor "Aggregates and filters logs"
            log_manager -> log_local_storage "Store to local logs"
            log_manager -> log_database "Store message"
        }

        deployment ENR "Development" "ENRDevelopmentDeployment" {
            include *
            autolayout lr
            animation {
                enrControllerInstanceDev
                enrollmentProviderInstanceDev
                statisticsProviderInstanceDev
                messagingProviderInstanceDev
                loggingProviderInstanceDev
                enrollmentDatabaseInstanceDev
                statisticsDatabaseInstanceDev
                logDatabaseInstanceDev
            }
            description "Deployment diagram for ENR in Development environment."
        }

        deployment ENR "Production" "ENRProductionDeployment" {
            include *
            autolayout lr
            animation {
                enrControllerInstanceProd
                enrollmentProviderInstanceProd
                statisticsProviderInstanceProd
                messagingProviderInstanceProd
                loggingProviderInstanceProd
                enrollmentDatabaseInstanceProd
                statisticsDatabaseInstanceProd
                logDatabaseInstanceProd
            }
            description "Deployment diagram for ENR in Production environment."
        }

        # Styles
        styles {
            element "Person" {
                background #1155AA
                color white
                shape person
                fontSize 20
            }
            element "Software System" {
                background #FAC507
                color black
                shape roundedBox
                fontSize 22
            }
            element "External Software System" {
                background grey
                color white
                shape roundedBox
                fontSize 22
            }
            element "Web Browser" {
                shape WebBrowser
                background grey
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
                background grey
            }
            element "Email System" {
                shape roundedBox
                background grey
            }
            element "Container" {
                background #149580
                color white
                shape roundedBox
                fontSize 18
            }
            element "Component" {
                background #23bb98
                color white
                shape box
                fontSize 16
            }
            element "Database" {
                background  #82dfc6
                shape cylinder
                fontSize 18
            }
            relationship "Relationship" {
                thickness 2
                color #555555
                properties {
                    name value
                }
            }
            element "Application API Gateway" {
                background #FF8C00
                shape hexagon
                color white
            }
        }
    }
}
