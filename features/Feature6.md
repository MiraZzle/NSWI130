# Feature: Subject creation

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
