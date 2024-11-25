# Feature: Viewing student’s schedule

As a student, I want to view my schedule with all my chosen subjects and see the necessary details about them (time, building, room), so I can plan my day accordingly.

#### Feature breakdown

1. The student is signed in and on the dashboard.
2. The student clicks on the “My Schedule” button.
3. The system shows a schedule overview for the current week.
4. The student can switch between daily and weekly views.
   - a) If the student selects the **Daily View**, the system shows all classes for the current day.
   - b) If the student selects the **Weekly View**, the system shows the schedule for the current week.
5. The student can choose the year and semester.
   - The student chooses the year.
   - The student chooses the semester.
   - The system shows the schedule for the chosen year and semester.
6. The student can click on any class block for details.
   - The system shows the class details (time, location, subject information).
7. The student can filter the schedule by subject, room, or lecture.
8. The student can export the schedule to an external calendar like Google Calendar or Outlook.
9. If a class is updated (time, building, room), the schedule reflects this change automatically.
10. The student is notified when there is any change in the schedule.

#### Responsibilities

##### Data collection

- Retrieve the list of the student's enrolled courses from the database.
- Ensure that each course’s details (time, building, room) are updated in the system.
- Validate that the retrieved data is correct and matches the student's current enrollments.

##### Schedule presentation

- Format the schedule to be user-friendly and visually organized.
- Enable students to view their schedule in a daily or weekly view

##### Data update

- Automatically update the schedule when course details change (time, room, etc.).
- Notify the student of any schedule updates or changes, such as room changes or cancellations.

##### Notification

- Provide reminders or alerts for upcoming classes (optional).
- Allow students to set reminders through the system.

##### Filtering

- Provide filter options for subject, room, lecture, or practical.
- Apply filters to the schedule and update the display based on user input.
- Ensure filters work for both daily and weekly views.

##### Calendar export

- Provide an export button on the schedule interface.
- Generate an exportable file (e.g., CSV, ICS) or API call for calendar systems.
- Confirm the export was successful.
