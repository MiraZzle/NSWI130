# Feature: Scheduling preferences for teachers

As a teacher, I want to edit/add preferences before the schedule is finalized by the scheduling committee, so that I can specify _when_ and _what_ classes I want to teach.

#### Feature breakdown

1. The teacher accesses their dashboard to set or edit scheduling preferences.
2. The system allows teachers to select their available time slots (depending on the school schedule, e.g., 8:00 - 9:30).
3. The system allows teachers to choose specific courses they want to teach.
4. The system saves teacher preferences for later access by the scheduling committee and shows them visualization.
5. The system provides conflict resolution suggestions (if multiple teachers prefer the same time slots or the schedule doesn't work for students).
6. The final schedule generation will take teacher preferences into account whenever possible.

#### Responsibilities

##### Preference Data Collection

- Provide an interface for teachers to select available time slots.
- Allow teachers to assign themselves to specific courses they are qualified to teach.
- Validate and store the input data (ensure preferences are valid).

##### Scheduling Committee

- Provide the committee access to the collected preferences.
- Allow the committee to review, adjust, or approve the final class schedule.
- Offer automated conflict resolution suggestions.

##### Conflict Detection

- Identify overlapping or conflicting preferences (e.g., two teachers choosing the same course or time).
- Suggest alternative time slots or distribute courses to other teachers based on availability.
- Allow teachers and the committee to resolve conflicts manually if needed.

##### Preference Storage

- Store the teacher preferences in a database.
- Allow teachers to revisit and edit their preferences until some scheduling deadline.
- Ensure the system logs any changes to the preferences and alerts the scheduling committee of updates.

##### Schedule Visualization

- Highlight conflicts between teacher preferences (e.g., two teachers want the same time and room).
- Display the possible final schedule to teachers.
