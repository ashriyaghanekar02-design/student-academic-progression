# Student Academic Progression & Portfolio System

## 1. What this project demonstrates
- PostgreSQL relational schema normalized into Students, Semesters, Subjects, and Portfolio Items.
- GUI for student CRUD/status update, semester records, subject/lab marks, and portfolio entries.
- Search by student name, SGPA/CGPA progression chart, gap-year indicator.
- Optional one-way export/synchronization to Google Sheets.
- Database-level foreign keys, CHECK constraints, UNIQUE constraints, and cascade deletes.

## 2. Fast setup (Windows)
1. Install Python 3.10+ from https://www.python.org/downloads/ and select **Add Python to PATH**.
2. Create a PostgreSQL database. Fast hosted option: create a project at https://supabase.com/ and copy its PostgreSQL connection string from project settings. Keep the password private.
3. Open the SQL editor in Supabase (or use pgAdmin/psql), paste all of `schema.sql`, and run it.
4. Extract this folder. Open Command Prompt in this folder.
5. Run:
   ```bat
   python -m venv .venv
   .venv\Scripts\activate
   pip install -r requirements.txt
   copy .env.example .env
   ```
6. Edit `.env`, replacing `DATABASE_URL` with your actual PostgreSQL connection string. Do not share the password or upload `.env`.
7. Run the app:
   ```bat
   streamlit run app.py
   ```
8. Browser opens the app. Add a test student, two semester records, a theory subject, a lab subject, one internal seminar, and one extracurricular activity.

## 3. Google Sheets setup (optional, takes extra time)
1. In Google Cloud Console, create/select a project and enable **Google Sheets API**.
2. Create a service account and download its JSON key. Save it as `service_account.json` in this project folder. Never upload this key publicly.
3. Create a Google Spreadsheet. Copy its ID from the URL between `/d/` and `/edit`.
4. Share the spreadsheet with the `client_email` shown inside the service-account JSON and give it Editor access.
5. Set `GOOGLE_SERVICE_ACCOUNT_JSON=service_account.json` and `GOOGLE_SHEET_ID=your_spreadsheet_id` in `.env`.
6. Restart the app and click **Sync database to Google Sheets now**. CRUD actions attempt to sync automatically after they succeed.

## 4. Demo sequence
1. Add student `TE001`, name `Demo Student`.
2. Add Semester 1 with SGPA 8.1, CGPA 8.1, no gap year.
3. Add Semester 2 with SGPA 8.6, CGPA 8.35, and optionally flag a gap year for demonstration.
4. Add theory subject `DBMS101` and lab subject `DBMSL101`, with marks within the maximum.
5. Add an internal seminar and an extracurricular activity.
6. Dashboard: search Demo Student, show chart and gap-year marker.
7. Sync to Google Sheets and open the four tabs.

Use clearly labelled **sample data** for the demo. Do not enter real student records without permission.

## 5. Schema and constraints
See `schema.sql`. Tables are `students`, `semesters`, `subjects`, and `portfolio_items`. Child tables reference parent tables with `ON DELETE CASCADE`. Marks and grade-point ranges are checked by the database. `UNIQUE` constraints prevent duplicate roll numbers, semester numbers per student, and subject codes within a semester.

## 6. Report outline
- Title page: project title, student name, roll number, class, subject, faculty, date.
- Abstract: one paragraph describing academic record management, normalized database, GUI, analytics and optional Sheets sync.
- Objectives and scope.
- Software/hardware requirements.
- ER diagram: Student 1—M Semester; Semester 1—M Subject; Student 1—M Portfolio Item.
- Table design and normalization to 3NF.
- Constraints and error handling.
- Screenshots: dashboard, student form, marks, portfolio filters, graph, spreadsheet.
- User manual and test cases.
- Limitations: two-way sync not implemented unless you build and test it.
- Conclusion and future scope.

## 7. Suggested test cases
- Valid student record inserts successfully.
- Duplicate roll number is rejected.
- SGPA 10.5 is rejected by the database.
- Marks greater than maximum marks are rejected.
- Semester number 9 is rejected.
- Deleting a student deletes related records via cascade.
- Search by partial name returns matching student.
- Gap-year flag creates a visible chart marker.
- Sync updates spreadsheet tabs when credentials are correctly configured.
