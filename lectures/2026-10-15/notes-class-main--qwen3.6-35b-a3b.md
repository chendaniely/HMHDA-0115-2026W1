# OLTP vs OLAP, ETL, and Real-World Health Data Storage

Date Time: 2026-10-15 18:00:00

Instructor: Daniel Chen

## Summary

This office hour session opened with student introductions, revealing a diverse cohort spanning clinical data leadership, technical writing, market research, and registered clinical counselling — most with little or no prior data analytics experience. Daniel then delivered a focused lecture on the vocabulary around data storage and processing systems, which is a topic that consistently confuses students. The core distinction he emphasized is between online transactional processing (OLTP) systems, which are optimized for fast, accurate data capture, and online analytical processing (OLAP) systems, which are optimized for summarizing and aggregating data to answer questions. He used the NHS COVID spreadsheet failure as a concrete example of what happens when data outgrows spreadsheet limits, and tied that to the ETL (extract, transform, load) process that moves data from transactional into analytical formats.

Daniel then demystified data cubes, explaining them as multi-dimensional groupings where each variable (month, patient, age) forms an axis, and roll-ups and drill-downs let you slice data at different levels of granularity. He connected this to the practical reality that analysts almost never touch the live transactional system directly — they work with batched snapshots stored in the analytics platform, often accessed through a browser rather than locally, for privacy and scale reasons. He also clarified data lakes versus data warehouses: the terms describe metaphors for storing both structured and unstructured data (like imaging) in one place, but getting analytics-ready data still requires significant work.

To give students hands-on material, Daniel introduced the Synthea (now called Synthetic Mass) resource, which provides synthetic hospital datasets in CSV format that mimic the relational structure and messiness of real EHR data. He showed how patient and encounter data are split across multiple tables, how heart attack cases are coded in multiple ways, and where students can find medical image datasets on Kaggle. The session concluded with Q&A about data tool access, the role of Weka versus Looker in the certificate, and how machine learning classification works on labeled medical images.

## Knowledge Points

### 1. Transactional vs. Analytical Systems

- **OLTP (Online Transactional Processing)**: Systems optimized for fast, accurate data capture at the point of service. Think of it like manually entering data into a spreadsheet — the priority is recording information quickly without errors, not analyzing it. Hospital EHR systems store data this way, organized by encounters.
- **OLAP (Online Analytical Processing)**: Systems optimized for summarizing, filtering, and aggregating data to answer questions. This is where analysts work. You rarely touch the live transactional feed; you get batched snapshots (e.g., "here is the hospital state as of this morning").
- **Key insight**: You cannot determine whether a dataset is transactional or analytical just by looking at it — it depends on the system it came from and its purpose.

### 2. ETL (Extract, Transform, Load)

- **Extract**: Pulling data out of a source (typically a transactional database).
- **Transform**: Cleaning, reshaping, and aggregating data to answer a specific question.
- **Load**: Moving the processed data into an analytics-ready format.
- ETL is typically automated via SQL scripts running on a schedule (hourly, daily, or weekly). Not every question can be answered in SQL, so further processing often happens later in tools like R or Python.
- There is no such thing as a universally "analytics-ready" dataset — every question may require different transformation.

### 3. Data Cubes and Aggregation

- A **data cube** is a way of thinking about data organized along multiple dimensions (axes). For example: month × patient × age.
- **Roll-ups**: Summarizing data into fewer groups (e.g., aggregate all ages into a single count per month).
- **Drill-downs**: Cutting data into more detailed groups (e.g., break down monthly counts by age ranges).
- Humans can visualize at most three dimensions at once; beyond that, data cubes are represented in flattened form.

### 4. Spreadsheet Limits and Data Volume

- Programs like Excel have hard limits on rows and columns. During COVID, the NHS hit Excel's column limit by appending a new column for each day's case count.
- Even coding languages have caps, but they are much larger because they do not need to render everything on screen.
- Healthcare data is especially large because it is stored by encounters — a single patient visiting multiple clinicians generates multiple rows. Counting unique patients (not encounters) requires extra processing.

### 5. Data Lakes vs. Data Warehouses

- **Data warehouse**: A structured store, like a house — data has defined schemas.
- **Data lake**: An unstructured store, like a lake — data can be dumped in any format, including images (X-rays, CT scans, MRIs) and text.
- Both solve the same fundamental problem: getting all data into one accessible place. Companies like Snowflake and Databricks are built around this idea.
- A data lake still requires significant work to extract analytics-ready data from it.

### 6. Synthea / Synthetic Mass

- A freely available synthetic dataset that mimics the structure and messiness of real hospital EHR data.
- Available at synthetic.mass (formerly known as Synthea).
- Comes in CSV format with multiple sheets/tables (patients, encounters, conditions, allergies, devices, etc.), reflecting the relational structure of real databases.
- Available in 10k, 100k, and larger versions — start with 10k for exploration.
- Useful for practicing data joining, filtering, and aggregation on realistic health data.
- Data is stored in **FHIR** format, a standard for hospital data exchange.

### 7. Privacy and Access in Healthcare Data

- Personal health information (SIN, MRN) is typically only accessible to a dedicated data team, not analysts directly.
- Analysts usually connect to analytics platforms through a web browser, not a local laptop, to keep PHI centralized and secure.
- Data requests may go through a ticketing system, and output may be delayed (batched) rather than live.

### 8. Visualization Tools in the Certificate

- This course uses **Looker Studio** (Google's dashboarding platform) for hands-on visualization.
- Tableau and Power BI are also used in healthcare, but licensing constraints limit Tableau access in the course.
- **Weka** is covered in the next course in the micro-certificate, not this one.
- The core goal is learning the vocabulary to describe data problems — AI tools and point-and-click platforms then handle the implementation in whichever tool you are using.

### 9. Medical Imaging and Machine Learning

- Medical images (eye scans, mammograms) are stored as sequences of zeros and ones.
- **Supervised machine learning** uses human-labeled training data (e.g., an ophthalmologist tags images as diabetic retinopathy at a given severity) to train models that classify new images.
- Disagreements between model predictions and human labels can flag potential errors in hospital systems.
- Image visualization (e.g., tracking tumor growth over time) and NLP on clinical text are covered in the next course, not this one.

## Questions

- **Q:** For an analyst, are OLTP and OLAP accessible through the same application, or are they separate systems?
  **A:** It depends on the organization. In many cases, analysts only access the OLAP side — either because they submit data requests to a dedicated data team that processes from the OLTP system, or because the platform (e.g., Databricks, Snowflake) separates the data by permissions. Practically speaking, almost everything an analyst touches is OLAP. The transactional system is rarely accessed directly.

- **Q:** Is ETL automated, and is it handled by a separate tool or by scripts?
  **A:** It is typically a series of automated scripts, usually written in SQL, that run on a regular cadence (hourly, daily, or weekly). Not every analytical question can be formulated in SQL, so ETL often provides a baseline dataset that analysts then further process in tools like R or Python.

- **Q:** What is the difference between a data lake and a data warehouse?
  **A:** They are metaphors for the same underlying goal: storing all data in one place. A data warehouse implies structured data (like a house with defined rooms). A data lake implies unstructured data as well — you can dump images, text, and any format into it. Both still require significant work to produce analytics-ready data. The lake metaphor emerged to accommodate non-rectangular data like medical imaging.

- **Q:** Will we get access to Weka in this course to create our own visualizations?
  **A:** Weka is covered in the next course in the micro-certificate. In this course, you will use Looker Studio (Google's platform) for hands-on visualization. The concepts transfer — whether it's Looker, Power BI, Tableau, or Weka, the ability to identify what is wrong with your data is the most important skill.

- **Q:** Does the Synthea dataset use relational tables, and do we need to set up a database to query it with SQL?
  **A:** The CSV download from Synthetic Mass comes as separate sheets (patients, encounters, conditions, etc.), which correspond to tables in a real database. You do not need to set up a database to explore it — you can open the CSV in Excel and use VLOOKUP or similar functions to join tables. In a real hospital setting, these would be separate tables queried with SQL.

---

- prompt: prompt-notes.md @ c082a6eab694
- prompt-hash: c082a6eab694
- model: qwen3.6-35b-a3b (requested: qwen3.6-35b-a3b)
- backend: opencode
- inputs: transcript-plaud.md
- generated: 2026-10-23
