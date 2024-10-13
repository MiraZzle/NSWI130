# Student Information System - Schedules (SCH)

## Core features and responsibilities

### Feature: Auto-generating schedules

As a committee, I must be able to automatically generate schedules so that I can have a starting block to work from, as the amount of data needed to create the schedules is far too overwhelming for a human. This way, I will be able to make some tweaks in the future or just choose from several generated schedules.

#### Feature breakdown

1. The committee opens their dashboard and initiates the generating process.
2. The system asks for input data.
3. The committee provides the input data.
4. The system validates the data, checking for any preliminary inconsistencies.
5. If the system finds inconsistencies:
   - a) It takes the committee back to the input data page, preserving all the given data.
   - b) It provides the committee with the necessary information to correct the discrepancies.
   - c) It also suggests some options.
6. If the system finds no inconsistencies, it stores the data with a log and takes the user to the final settings page.
7. In the settings page, the committee chooses options for the algorithm and initiates it.
8. The algorithm runs.
9. If the algorithm runs into any issue:
   - a) It shows a log with all errors.
   - b) It asks the committee what they want to do next.
10. If the algorithm succeeds, it stores the schedules with a log and shows the committee the results.
11. The committee can download the schedule, send notifications about the new schedules, or modify the schedule (handled by another feature).
12. The dashboard gets updated so that the committee can now easily work with the auto-generated schedules.

#### Responsibilities

##### Asking for input data responsibilities

- Provide intuitive forms for data entry - selection of courses, room availability, number of students, teachers, and other preferences.
- Allow for a batch upload of some or all criteria via a .CSV file.
- Give the option to fill data fields with old stored data.

##### Validating data entry responsibilities

- Check the format.
- Check the data for missing or incorrect information (like duplicate courses or non-existent rooms).

##### Finding inconsistencies responsibilities

- Temporarily maintain the data while highlighting fields with issues.
- Display clear messages with guidance for correction.
- Show potential fixes (e.g., if a teacher is missing, show all existing teachers, or if the lectures are incorrect, show the historically working ones).

##### Finding no inconsistencies responsibilities

- Create a data log for future reference (who entered the data, when).
- Save the data in a secure database and with correct formatting for further use.

##### Adjusting settings responsibilities

- Provide options for strategies from a pre-set list (prioritizing lectures over practicals, optimizing room capacities, optimizing energy savings, prioritizing a day off for everyone).
- Provide the option to set the number of schedules to be generated.
- Allow for manual tweaking using embedded code.

##### Running the algorithm responsibilities

- Parse, structure, and normalize the input data.
- Create a schedule matrix and assign courses.
- Check for conflicts and resolve them.
- Do further schedule optimization.
- Validate the schedules (another core feature).

##### Running into issues responsibilities

- Log any conflicts or errors in a readable format.
- Offer options like retrying the algorithm again, going back to data inputs, or changing the settings.

##### Successful algorithm responsibilities

- Store all generated schedules along with associated logs (timestamps, inputs used, settings used).
- Display the schedules with options (calendar view, weekly schedule breakdown, room schedule).
- Show potential problems with all schedules.
- Show scores given to the schedules by the algorithm.

##### Post-generation activities responsibilities

- Show options for readable formats to download the schedules.
- Show options for notifying students and teachers and crafting a message.
- Offer a modification process (handled by another feature).

##### Updating the dashboard responsibilities

- Show the generated schedules with their summaries.
- Allow easy options for re-running the algorithm, viewing the schedules, or editing them.

---

### Feature: Scheduling preferences for teachers

As a teacher, I want to edit/add preferences before the schedule is finalized by the scheduling committee, so that I can specify _when_ and _what_ classes I want to teach.

#### Feature breakdown

- The teacher accesses their dashboard to set or edit scheduling preferences.
- The system allows teachers to select their available time slots (depending on the school schedule, e.g., 8:00 - 9:30).
- The system allows teachers to choose specific courses they want to teach.
- The system saves teacher preferences for later access by the scheduling committee and shows them visualization.
- The system provides conflict resolution suggestions (if multiple teachers prefer the same time slots or the schedule doesn't work for students).
- The final schedule generation will take teacher preferences into account wherever possible.

#### Responsibilities

##### Preference Data Collection responsibilities

- Provide an interface for teachers to select available time slots.
- Allow teachers to assign themselves to specific courses they are qualified to teach.
- Validate and store the input data (ensure preferences are valid).

##### Scheduling Committee responsibilities

- Provide the committee access to the collected preferences.
- Allow the committee to review, adjust, or approve the final class schedule.
- Offer automated conflict resolution suggestions.

##### Conflict Detection responsibilities

- Identify overlapping or conflicting preferences (e.g., two teachers choosing the same course or time).
- Suggest alternative time slots or distribute courses to other teachers based on availability.
- Allow teachers and the committee to resolve conflicts manually if needed.

##### Preference Storage responsibilities

- Store the teacher preferences in a database.
- Allow teachers to revisit and edit their preferences until some scheduling deadline.
- Ensure the system logs any changes to the preferences and alerts the scheduling committee of updates.

##### Schedule Visualization responsibilities

- Highlight conflicts between teacher preferences (e.g., two teachers want the same time and room).
- Display the possible final schedule to teachers.

---

### Feature: Validating schedules

As a scheduling committee, I want to manually validate any schedule so that I may be notified if the schedule breaks any rules (e.g., room overlaps, time conflicts, instructor availability).

#### Feature breakdown

1. The scheduling committee (SC) receives or creates a schedule.
2. A member of SC logs into the management dashboard and navigates to the schedule validation section.
3. A specific schedule is selected for validation.
4. The SC member initiates the validation process.
5. The system checks the schedule for conflicts or violations.
6. If any issues are found (e.g., room double-booking or time conflicts), the SC member is notified with details on the violation.

#### Responsibilities

##### Schedule collection responsibilities

- Ensure schedules are stored in a centralized database.
- Schedules should be accessible and easily viewable through a user-friendly interface.

##### Validation responsibilities

- Implement a rule engine for checking schedule conflicts (e.g., overlapping rooms, instructor availability).
- Validate schedule constraints based on defined rules (e.g., time slots, resource allocation).
- Generate a detailed validation report.

##### Error notification responsibilities

- Detect and display rule violations during the validation process.
- Notify the SC member of any issues via the dashboard and email notifications.
- Provide actionable error messages for easy resolution of conflicts.

##### Reporting and logging responsibilities

- Generate a detailed report of validation results, highlighting conflicts and suggested resolutions.
- Log validation activities and results for recovery purposes.
- Allow SC members to download or export validation reports.

---

### Feature: Viewing student’s schedule

As a student, I want to view my schedule with all my chosen subjects and see the necessary details about them (time, building, room), so I can plan my day accordingly.

#### Feature breakdown

1. The student has already enrolled in all the necessary courses (prerequisite).
2. The system fetches the student's enrolled courses from the database.
3. The system displays the schedule with all necessary details in an organized manner.
4. If a course is updated (time, building, room), the schedule reflects this change automatically.
5. The student is notified when there is any change in the schedule.

#### Responsibilities

##### Data collection responsibilities

- Retrieve the list of the student's enrolled courses from the database.
- Ensure that each course’s details (time, building, room) are updated in the system.
- Validate that the retrieved data is correct and matches the student's current enrollments.

##### Schedule presentation responsibilities

- Format the schedule to be user-friendly and visually organized.
- Enable students to filter their schedule by date, as there can be lessons that only happen once in a fortnight.

##### Data update responsibilities

- Automatically update the schedule when course details change (time, room, etc.).
- Notify the student of any schedule updates or changes, such as room changes or cancellations.

##### Notification responsibilities

- Provide reminders or alerts for upcoming classes (optional).
- Allow students to set reminders through the system or link the schedule to an external calendar.

---

### Feature: Viewing teacher’s schedule

As a teacher, I want to view my schedule with all the classes and practicals I am teaching, and see the details of these classes so that I can manage my time.

#### Feature breakdown

1. The teacher is signed in and on the dashboard.
2. The teacher clicks on the “My Schedule” button.
3. The system shows a schedule overview for the current week.
4. The teacher can switch between daily and weekly views.
   - a) If the teacher selects the Daily View, the system shows all classes for the current day.
   - b) If the teacher selects the Weekly View, the system shows the schedule for the current week.
5. The teacher can choose the year and semester.
   - 1. The teacher chooses the year.
   - 2. The teacher chooses the semester.
   - 3. The system shows the schedule for the chosen year and semester.
6. The teacher can click on any class block for details.
   - The system shows the class details (time, location, subject information

). 7. The teacher can filter the schedule by subject, room, lecture, or practical. 8. The teacher can export the schedule to an external calendar like Google Calendar or Outlook.

#### Responsibilities

##### Navigation responsibilities

- Capture click events on the “My Schedule” button.
- Redirect the teacher to the full schedule view.
- Load the appropriate schedule (daily or weekly) based on preferences.

##### Schedule rendering responsibilities

- Retrieve the weekly schedule for the teacher.
- Organize classes and events into a grid format by day and time.
- Ensure correct labeling of subjects, lecture or practical, and locations.

##### View toggling responsibilities

- Provide toggle functionality for switching between daily and weekly views.
- Refresh the schedule based on the selected view.
- Maintain the current day or week when switching views.

##### Year and semester selection responsibilities

- Provide options for selecting the year.
- Provide options for selecting the semester.
- Validate the selected year and semester.
- Ensure available year and semester options are accurate and up-to-date.
- Fetch and display the schedule for the chosen year and semester.

##### Class details retrieval responsibilities

- Capture click events on class blocks.
- Fetch detailed class information such as course title, time, location, and resources.
- Display the information in a pop-up or side panel.

##### Filtering responsibilities

- Provide filter options for subject, room, lecture, or practical.
- Apply filters to the schedule and update the display based on user input.
- Ensure filters work for both daily and weekly views.

##### Calendar export responsibilities

- Provide an export button on the schedule interface.
- Generate an exportable file (e.g., CSV, ICS) or API call for calendar systems.
- Confirm the export was successful.

---

Certainly! Here's the entire **Subject Creation** section:

---

### Feature: Subject creation

As a teacher, I want to create a subject that I am going to teach, so it can be included in the schedule generation. This applies to optional subjects that don’t have to be taught. As the scheduling committee, I want to automatically generate subjects that must be taught according to the study plans of specializations.

#### Feature breakdown

##### For Teachers: Subject Creation

1. The teacher logs into the management dashboard and navigates to the subject creation section.
2. The system checks if it’s the right time to create subjects for the next semester, as defined in the harmonogram.
3. If it's not the right time, a message is displayed to inform the user.
4. If it’s the right time, a form is displayed for the teacher to input subject details:
   - The name of the subject,
   - The number of credits for the subject,
   - The format of the subject and its requirements (e.g., 2/2, 2/1, 2/0, 0/2),
   - Whether it’s only an exam, only credit, or both,
   - The number of exercises they want for the subject,
   - The names of exercise teachers (if applicable),
   - Subject information that helps students understand what it’s about.
5. The teacher clicks "Create," and the subject is added to the system.

##### For Teachers: Editing

1. The teacher wants to edit or delete their own created subjects.
2. The teacher logs into the management dashboard and navigates to the "My Subjects" section.
3. The system checks if it's the right time for editing subjects, using the timeframe defined in the harmonogram.
4. If it’s not the right time, a message is displayed to inform the teacher.
5. If it’s the right time, the system displays a list of subjects created by the teacher.
6. The teacher selects the subject they wish to edit, and the system opens a form pre-filled with the current information of the subject.
7. The teacher can modify any field, such as subject name, credits, format (lectures/exams/requirements), number of exercises, and subject information (for student reference).
8. The teacher clicks "Save" to update the subject in the system.
9. The system validates the changes and updates the subject in the database.
10. The teacher can also delete a subject by selecting it and clicking the "Delete" button.
11. Upon deletion, the system prompts for confirmation and then removes the subject from the database.
12. If the deletion is successful, a success message is displayed; if not, an error message is shown.

##### For Scheduling Committee: Subject Generation

1. The committee wants to generate all subjects that must be taught according to study plans, so no one has to do it manually.
2. The committee chief logs into the management dashboard and navigates to the subject generation section.
3. The system checks if it’s the right time to generate subjects for the next semester, based on the harmonogram.
4. If it’s not the right time to generate subjects, or if they’ve already been generated, a message is displayed to inform the user.
5. If subjects were already generated, a message is displayed to notify the user.
6. If it’s the right time and subjects weren’t generated yet, a "Generate Subjects from Study Plan" button is available.
7. The user clicks the button, and subjects are generated based on the current study plan.

##### For Scheduling Committee: Editing

1. A committee member wants to edit or delete any subject in the system, regardless of whether it was created manually by a teacher or automatically generated from a study plan.
2. The committee member logs into the management dashboard and navigates to the "All Subjects" section.
3. The system checks if it’s the right time for editing subjects, using the defined timeframe from the harmonogram.
4. If it’s not the right time, a message is displayed to inform the committee member.
5. If it’s the right time, the system displays a list of all subjects, including manually created and automatically generated ones.
6. The committee member selects the subject they wish to edit, and the system opens a form pre-filled with the current information of the subject.
7. The committee member can modify any field, such as subject name, credits, format (lectures/exams/requirements), number of exercises, and other subject information (for student reference).
8. The committee member clicks "Save" to update the subject in the system.
9. The system validates the changes and updates the subject in the database.
10. The committee member can also delete a subject by selecting it and clicking the "Delete" button.
11. Upon deletion, the system prompts for confirmation and then removes the subject from the database.
12. If the deletion is successful, a success message is displayed; if not, an error message is shown.

#### Responsibilities

##### Getting Data from Other Systems

- Fetch the year’s harmonogram to check whether subject creation or editing is allowed.
- Fetch the current study plans.
- Fetch the number of students in different specializations.

##### List of Created Subjects

- Load the created subjects from the database.
- For committee members, all subjects should be displayed; for teachers, only those they created themselves should be shown.

##### Subject Creation responsibilities

- Ensure that all necessary data for subject creation is provided by the user.
- Create a new subject in the database.

##### Subject Editing responsibilities

- Check if the user has permission to edit the subject (teachers can only edit their own subjects).
- Display the current subject information to the user.
- Update the subject in the database after validation.

##### Subject Deletion responsibilities

- Check if the user has permission to delete the subject (teachers can only delete their own subjects).
- Delete the subject from the database after confirmation.

##### Subject Generation from Study Plan responsibilities

- Retrieve information on whether subjects have already been generated or not.
- Load the necessary data from the study plan.
- Process the number of students in each specialization to determine how many lectures and exercises are needed for each generated subject.
- Generate subjects with the appropriate name, number of credits, format (2/2, 2/1, 0/2, etc.), and information on exercises and their teachers.
- Save the newly generated subjects into the database.

##### Notifications

- Notify the committee chief when the right time comes to generate subjects.
- Notify all teachers when they can start creating subjects.
- Notify a teacher if their subject is edited by the committee.
- Notify a teacher if they are assigned as a lecturer or exercise teacher for a subject.
