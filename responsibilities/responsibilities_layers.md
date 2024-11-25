# Storage

- Store validation report (I)
- Store schedule (I)
- Store settings. (I)
- Store auto-generative schedule input data. (I)

# Data receiver

- Receive schedule to validate (B)
- Receive input data for generating schedules. (B)
- Validate newly added data (B)
- Display data entry inconsistencies. (P)

# Data collection

- Retrieve the student's enrolled courses from the database (I)
- Retrieve details for all the enrolled courses from the database (I)

# Data analysis

- Automatically update the schedule when course details change (time, room, etc.) (B)

# Showing schedules

- Notify about new scheduls. (P)
- Show schedule. (P)
- Filter the schedule by day/week (P)
- Show details for each subject (P)

# Notifier

- Notify SC member of conflicts - dashboard (P)
- Notify SC member of conflicts - email (I)
- Notify students of upcoming classes (P)
- Notify students of changes in classes (P)

# Logging

- Log algorithm information given. (I)
- Log algorithm status (errors, successes). (I)

# Dashboard

## Showing forms

- Provide intuitive forms for schedule generation data entry. (P)

## Validation report displayer

- Display validation report - i.e. display conflicts or OK (P)

# Rule engine

- Validating rule engine (B)
- Scheduling rule engine. (B)
- Adjust algorithm settings. (P)
- Process data. (B)

---

### Feature: Scheduling preferences for teachers

As a teacher, I want to edit/add preferences before the schedule is finalized by the scheduling committee, so that I can specify _when_ and _what_ classes I want to teach.

#### Feature breakdown

1. The teacher accesses their dashboard to set or edit scheduling preferences.
2. The system allows teachers to select their available time slots (depending on the school schedule, e.g., 8:00 - 9:30).
3. The system allows teachers to choose specific courses they want to teach.
4. The system saves teacher preferences for later access by the scheduling committee and shows them visualization.
5. The system provides conflict resolution suggestions (if multiple teachers prefer the same time slots or the schedule doesn't work for students).
6. The final schedule generation will take teacher preferences into account whenever possible.

#### Responsibilities

##### Selecting available time slots interface (P)

- Teachers can view and select available time slots in a user-friendly format (e.g., calendar or dropdown).

##### Selecting specific course interface (P)

- Teachers can choose from a list of courses they are qualified to teach.

##### Schedule visualization (P)

- Display a calendar that shows the teacher's current preferences and conflicts

##### Resolution interface (P)

- If there are conflicts, offer an interface that highlights suggestions for editing schedule

##### Validate timeslots (B)

- Ensure the teacher's chosen time slots are valid and do not overlap their existing already scheduled class, if exists

##### Validate course selection (B)

- Check that the teacher is qualified and authorized to teach the selected courses

##### Conflict resolution (B)

- Identify conflicts in time slots or course assignments (e.g., two teachers wanting the same time or course)
  and provide conflict resolution options (e.g., alternative times)

##### Preferences schedule generation (B)

- Generate a tentative schedule using teacher preferences, taking into account conflicts and school policies (like room availability)

##### Enforce deadlines (B)

- Prevent teachers from editing preferences after a certain deadline.

##### Store preferences (I)

- Store teacher time slot preferences and selected courses in a persistent database. Ensure data is versioned for auditing.

##### Retrieve stored preferences (I)

- Allow teachers or scheduling committee (based on authorization) to access saved preferences at any time before finalization.

##### Log changes (I)

- Keep a log of all changes to preferences, including timestamps and the user making the change.
- Keep a log of all proposed conflicts.

##### Store final schedule (I)

- Save the outcome of conflict resolutions, whether automated or manually handled by teachers or committee members.

# Modules

# Logging

- Log changes (I)

# Data collection

- Retrieve stored preferences (I)

# Storage

- Store final schedule (I)
- Store preferences (I)

# Algorithm

- Enforce deadlines (B)
- Preferences schedule generation (B)
- Conflict resolution (B)
- Validate course selection (B)
- Validate timeslots (B)

# Interface

- Resolution interface (P)
- Selecting available time slots interface (P)
- Selecting specific course interface (P)
- Schedule visualization (P)

---

Feature: Show teacher's schedule
Responsibilities
Data collection
Retrieve teacher's classes and practical from database (I)
Retrieve details for subjects, classes, practicals from database (I)

Data update
Validate and apply filter of the schedule (subject, room, lecture or practical) (B)
Validate the selected year and semester (B)

Exporting
Generate an exportable file (e.g., .csv, .ics) or API call for calendar systems. (B)

Schedule presentation
Show the schedule (P)
Show the schedule by week/day(P)
Show detail for every subject (P)
Show filter (subject, room, lecture or practical) (P)

---

#### **Responsibilities Improved**

##### **Getting Data from Other Systems**

- Fetch the year’s harmonogram to check whether subject creation or editing is allowed. (I)
- Fetch the current study plans. (I)
- Fetch the number of students in different specializations. (I)

##### **List of Created Subjects**

- Load the created subjects from the database. (I)
- Filter the subjects, for committee members, all subjects should be loaded; for teachers, only those they created themselves should be loaded (B)
- Display the received subjects (P)

##### **Subject Creation**

- Ensure that all necessary data for subject creation is provided by the user on the frontend (P)
- Validate the incoming data for subject creation on the backend (B)
- Create a new subject in the database (I)

##### **Subject Editing**

- Check if the user has permission to edit the subject (teachers can only edit their own subjects) (B)
- Get the current subject information from the database (I)
- Display the current subject information to the user and enable its editing (P)
- Validate the data for changing the subject on the backend (B)
- Update the subject in the database (I)

##### **Subject Deletion**

- Check if the user has permission to delete the subject (teachers can only delete their own subjects) (B)
- Make user confirm his decision (P)
- Delete the subject from the database after confirmation (I)

##### **Subject Generation from Study Plan**

- Retrieve information on whether subjects have already been generated or not (I)
- Load the necessary data from the study plan (I)
- Process the number of students in each specialization to determine how many lectures and exercises are needed for each generated subject (B)
- Generate subjects with the appropriate name, number of credits, format (2/2, 2/1, 0/2, etc.), and information on exercises and their teachers (B)
- Save the newly generated subjects into the database (I)

##### **Notifications**

- Notify the committee chief when the right time comes to generate subjects - email (I)
- Notify all teachers when they can start creating subjects - email (I)
- Notify a teacher if their subject is edited by the committee - email (I)
- Notify a teacher if they are assigned as a lecturer or exercise teacher for a subject - email (I)
