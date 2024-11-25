# Feature: Viewing teacher’s schedule

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
   - The system shows the class details (time, location, subject information). 7. The teacher can filter the schedule by subject, room, lecture, or practical. 8. The teacher can export the schedule to an external calendar like Google Calendar or Outlook.

#### Responsibilities

##### Navigation

- Capture click events on the “My Schedule” button.
- Redirect the teacher to the full schedule view.
- Load the appropriate schedule (daily or weekly) based on preferences.

##### Schedule rendering

- Retrieve the weekly schedule for the teacher.
- Organize classes and events into a grid format by day and time.
- Ensure correct labeling of subjects, lecture or practical, and locations.

##### View toggling

- Provide toggle functionality for switching between daily and weekly views.
- Refresh the schedule based on the selected view.
- Maintain the current day or week when switching views.

##### Year and semester selection

- Provide options for selecting the year.
- Provide options for selecting the semester.
- Validate the selected year and semester.
- Ensure available year and semester options are accurate and up-to-date.
- Fetch and display the schedule for the chosen year and semester.

##### Class details retrieval

- Capture click events on class blocks.
- Fetch detailed class information such as course title, time, location, and resources.
- Display the information in a pop-up or side panel.

##### Filtering

- Provide filter options for subject, room, lecture, or practical.
- Apply filters to the schedule and update the display based on user input.
- Ensure filters work for both daily and weekly views.

##### Calendar export

- Provide an export button on the schedule interface.
- Generate an exportable file (e.g., CSV, ICS) or API call for calendar systems.
- Confirm the export was successful.
