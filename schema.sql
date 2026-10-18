CREATE TABLE IF NOT EXISTS students (
  student_id SERIAL PRIMARY KEY,
  roll_no VARCHAR(30) UNIQUE NOT NULL,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) UNIQUE,
  department VARCHAR(100) NOT NULL DEFAULT 'Electrical and Computer Engineering',
  admission_year INT CHECK (admission_year BETWEEN 2000 AND 2100),
  secondary_school VARCHAR(160),
  secondary_percentage NUMERIC(5,2) CHECK (secondary_percentage BETWEEN 0 AND 100),
  higher_secondary_school VARCHAR(160),
  higher_secondary_percentage NUMERIC(5,2) CHECK (higher_secondary_percentage BETWEEN 0 AND 100),
  current_status VARCHAR(30) NOT NULL DEFAULT 'Studying'
    CHECK (current_status IN ('Studying','Graduated','Dropped','On Leave'))
);

CREATE TABLE IF NOT EXISTS semesters (
  semester_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  semester_no INT NOT NULL CHECK (semester_no BETWEEN 1 AND 8),
  academic_year VARCHAR(20),
  sgpa NUMERIC(4,2) CHECK (sgpa BETWEEN 0 AND 10),
  cgpa NUMERIC(4,2) CHECK (cgpa BETWEEN 0 AND 10),
  gap_year_before BOOLEAN NOT NULL DEFAULT FALSE,
  notes TEXT,
  UNIQUE(student_id, semester_no)
);

CREATE TABLE IF NOT EXISTS subjects (
  subject_id SERIAL PRIMARY KEY,
  semester_id INT NOT NULL REFERENCES semesters(semester_id) ON DELETE CASCADE,
  subject_code VARCHAR(30) NOT NULL,
  subject_name VARCHAR(160) NOT NULL,
  subject_type VARCHAR(10) NOT NULL CHECK (subject_type IN ('Theory','Lab')),
  marks_obtained NUMERIC(5,2) NOT NULL CHECK (marks_obtained BETWEEN 0 AND 100),
  max_marks NUMERIC(5,2) NOT NULL DEFAULT 100 CHECK (max_marks > 0 AND max_marks <= 100),
  CHECK (marks_obtained <= max_marks),
  UNIQUE(semester_id, subject_code)
);

CREATE TABLE IF NOT EXISTS portfolio_items (
  item_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  item_type VARCHAR(20) NOT NULL CHECK (item_type IN ('Seminar','Activity')),
  category VARCHAR(30) NOT NULL,
  title VARCHAR(180) NOT NULL,
  participation_level VARCHAR(20) CHECK (participation_level IN ('Internal','External')),
  event_date DATE,
  description TEXT,
  CHECK (
    (item_type = 'Seminar' AND participation_level IN ('Internal','External'))
    OR item_type = 'Activity'
  )
);

CREATE INDEX IF NOT EXISTS idx_students_name ON students(full_name);
CREATE INDEX IF NOT EXISTS idx_semesters_student ON semesters(student_id);
CREATE INDEX IF NOT EXISTS idx_portfolio_student ON portfolio_items(student_id);
