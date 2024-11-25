# Feature: Auto-generating schedules

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

##### Validating data entry

- Check the format.
- Check the data for missing or incorrect information (like duplicate courses or non-existent rooms).

##### Finding inconsistencies

- Temporarily maintain the data while highlighting fields with issues.
- Display clear messages with guidance for correction.
- Show potential fixes (e.g., if a teacher is missing, show all existing teachers, or if the lectures are incorrect, show the historically working ones).

##### Finding no inconsistencies

- Create a data log for future reference (who entered the data, when).
- Save the data in a secure database and with correct formatting for further use.

##### Adjusting settings

- Provide options for strategies from a pre-set list (prioritizing lectures over practicals, optimizing room capacities, optimizing energy savings, prioritizing a day off for everyone).
- Provide the option to set the number of schedules to be generated.
- Allow for manual tweaking using embedded code.

##### Running the algorithm

- Parse, structure, and normalize the input data.
- Create a schedule matrix and assign courses.
- Check for conflicts and resolve them.
- Do further schedule optimization.
- Validate the schedules (another core feature).

##### Running into issues

- Log any conflicts or errors in a readable format.
- Offer options like retrying the algorithm again, going back to data inputs, or changing the settings.

##### Successful algorithm

- Store all generated schedules along with associated logs (timestamps, inputs used, settings used).
- Display the schedules with options (calendar view, weekly schedule breakdown, room schedule).
- Show potential problems with all schedules.
- Show scores given to the schedules by the algorithm.

##### Post-generation activities

- Show options for readable formats to download the schedules.
- Show options for notifying students and teachers and crafting a message.
- Offer a modification process (handled by another feature).

##### Updating the dashboard

- Show the generated schedules with their summaries.
- Allow easy options for re-running the algorithm, viewing the schedules, or editing them (handled by another feature); basically the previous page.
