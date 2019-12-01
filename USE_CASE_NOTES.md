#### EXAMPLE CASE NOTES

My biggest project where it was very helpful was a data sync / transfer project - between a variety of ancient and modern machines (with a wide variety of trigger needs, processing, formats and transfer needs):
1. **Inputs** (master systems with a variety of triggers and payload sizes)
  - HR Server (master data source for employees)
  - Admission Server (master data source for students and parents) - API
  - Phone assignment server (master data source for all school phones - employees and students)
  - Finance server
  - Photographer (student photos)
2. **Processing** (a variety of processing needs depending on source and data need)
  - mostly what data was needed
3. **Outputs** (both formatting and transfer and security rules)
  - Formats (CSV, PNG, EXCEL, API, etc)
  - Transport (FTP, SCP, API, remote CLI via SSH, etc)
  - Data Consumer systems
    - Parental Payments Services Management
    - LDAP Server (master authentication & authorization)
    - Google Services (email, google docs, etc)
    - Cantonal Immigration Applications
    - Academic Management Server (classes, grades, attendance)
    - Travel & Dormitory Absence Tracking (and fire lists)
    - Health Records Creation
    - Parent Portal user access
    - Cell Phone / Office Phone lists
    - Student / Staff ID Formatter & Printer
    - Restricted WEB Portal (Rails)
      - for access to student photos
      - start of year Dormitory assignment planning
      - Course assignment planning
