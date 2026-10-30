# Office hours: OLTP vs. OLAP, ETL, and where hospital data lives

Date Time: 2026-10-15

Instructor: Daniel Chen

## Summary

The first Thursday office-hours session of the term. The instructor opened with logistics: cameras are optional, the session is recorded, and he now publishes text-only transcripts (voices are not released, speakers are tagged `Speaker 1`, `Speaker 2`, …) that he also feeds to an AI model to produce summaries. Students introduced themselves with widely varying backgrounds, from no data experience at all to a clinical data and AI solutions lead. The format is a short talk on that week's material plus a co-working window for questions and homework; the instructor stays until the last person leaves, around 7:00 PM.

The main talk was a vocabulary review of week one's readings and videos: online transaction processing (OLTP) versus online analytical processing (OLAP), extract-transform-load (ETL), and why health data is stored the way it is. The central point: whether a dataset is "transactional" or "analytical" is a property of the system that stores it, not something you can see by looking at the rows; and there is no such thing as an analytics-ready dataset, because every question you ask may need the data in a different format. The instructor illustrated with the 2020 NHS example, where daily COVID counts were appended as new columns to one Excel sheet until the spreadsheet's column limit was hit and historical data started being overwritten.

He then pointed the class to Synthea, a synthetic dataset that mimics how hospital data is organized, downloadable in CSV with 10,000- and 100,000-patient versions. He suggested starting with the smaller file and sketched a realistic practice question: 30-day readmission after a heart attack, which is harder to answer than it looks because a heart attack is coded several different ways.

The second half was student questions: how OLTP and OLAP are actually accessed in practice, how ETL runs (scripts, usually SQL), data lakes versus data warehouses, which tools the course uses hands-on (Looker, not Tableau; Weka is a later course), and whether imaging and text data are covered (mostly the next course, in the machine-learning direction). He closed with the Kaggle breast-cancer story in which a model learned "ID < 80 ⇒ cancer" from how the images happened to be sorted: explore your data before fitting anything, because the code that fits a model is trivial and the hard part is giving it the right inputs.

## Knowledge Points

### 1. Transactional (OLTP) vs. analytical (OLAP) systems

- **Online transaction processing (OLTP)**: systems that record data as it happens. Their main goal is that data gets captured quickly and without errors. Electronic health records are stored this way, organized by encounters, and the layout is optimized for financial reporting — which does not make it ready for health analytics.
- **Online analytical processing (OLAP)**: the systems analysts actually work in, where data is aggregated and cut up for questions.
- **You can't tell by looking at the data**: a table of encounters looks the same whether it came from a transactional or an analytical system. The distinction is about the storage system, not the rows.
- **Spreadsheet analogy**: hand-curating a budget in Excel or Google Sheets is a transactional system — you copy things in (say, from a credit-card statement) to record them; analysis happens on top of that.
- **Encounter-based storage**: an encounter is a person moving through the hospital and seeing different clinicians. An encounter row stores the record number and that encounter's information; demographics live in a separate table so they are written once, not repeated. Fewer repeated fields means data can be written faster.
- **Snapshot, not live**: raw data arrives at high volume and speed, so systems capture it first and process it later in batch, on an hourly, daily, or weekly cadence. Analysts typically get a snapshot ("the hospital state as of last night"), not a live feed; needing live data is rare.
- **No such thing as an analytics-ready dataset**: any question you ask may need the data in a different format, so extract-transform-load work is always required. Even when you hand-curate a dataset, leaving breadcrumbs on how it was processed helps down the road.

### 2. ETL

- **ETL (extract, transform, load)**: moving data from the transactional system into the analytics platform in the shape your question needs. Depending on the systems in use, the letters come in other permutations (ELT and the like).
- **How it runs in practice**: a series of scripts against a database, data warehouse, or lake — usually in SQL, the language databases use. Not every data question can be formulated directly in SQL; a common pattern is an initial pull ("just these columns from these tables") followed by further processing in your own tools. That is why this course later adds R on top: you will get SQL output or a dataset, and still have to process it for your question.

### 3. Data size and storage limits

- **Spreadsheet limits**: Excel has a cap on the number of rows and columns (several hundred columns). Coding languages have far higher limits, partly because they do not have to visually render every cell, which saves compute.
- **The NHS example (2020)**: the British NHS was appending a new column for each day's COVID case counts to a single Excel sheet. When the column limit was hit, the sheet kept adding data but started replacing the last row, so historical data was silently lost. A reminder to be mindful of how much you append to a spreadsheet.
- **Many rows, few columns**: relational tables are deliberately broken up into more tables with more rows rather than one wide table — to reduce duplication and because relational databases do not like very high column counts.

### 4. Data cubes, warehouses, and lakes

- **Data cube**: the pre-aggregated form of a dataset. Each variable is an axis of the cube — for example month, unique people, age, a count, minimum/maximum age — and a question like "how many unique people in September, and what is their average age?" maps to cutting the cube along those axes. You can only visualize at most about three variables at once, but the data can be cut along many more.
- **Roll-ups and drill-downs**: on an analytics platform you aggregate into fewer groups (roll up, e.g. stop breaking down by age) or cut into more groups (drill down).
- **Data warehouse**: the "house" metaphor — structured storage, one place for your data.
- **Data lake**: the "water" metaphor — a giant place where everything gets dumped, including data that is not rectangular at all (X-rays, CT and MRI scans, which are image data). It solves the storage problem; you still have to do the work to pull pieces out and get them analytics-ready.
- **Snowflake and Databricks**: the two largest platforms, built around the goal of storing all your data in one place and putting an analytics tool on top.
- **SQL**: the language used to query databases and warehouses; the extract/transform/load step is typically handled by SQL scripts in that layer.
- **Practical rule of thumb**: if you are analyzing and pointing at a dataset, it is almost certainly the analytics side — you very rarely need the live hospital feed. "Practically, it is all OLAP."

### 5. Synthea: synthetic practice data

- **Synthea**: a synthetically generated dataset that mimics what hospital data looks like and how it is stored. It can be downloaded as CSV (openable in Excel). The website was recently renamed; the instructor shared the link in the Zoom chat and the recording.
- **10k vs. 100k**: the CSV download comes in a 10,000-patient and a 100,000-patient version. Start with the smaller one so your computer is not struggling — the columns are the same, only more rows. Some of these files are 2 GB CSVs.
- **FHIR**: one of the standard formats that hospital data is stored and exported in; many tools can read FHIR. That is one reason to practice with a resource like this.
- **Table structure**: the data arrives as several separate tables — patients, encounters, conditions, allergies, devices, immunizations, observations — mirroring how a transactional database organizes it (a patient record number plus per-encounter information). Patients and encounters together give you "showed up when" plus demographics. Combining the tables (with joins in a database, or `VLOOKUP` in Excel) is part of the work.
- **A realistic practice question**: preventing 30-day readmission after a heart attack (myocardial infarction, MI). In the United States, insurers do not reimburse a hospital for a readmission within 30 days, so hospitals balance keeping a patient in a bed longer against discharging and hoping the patient does not return. Even a simple version — "how many heart-attack cases do we have today?" — is more complicated than it looks, because a heart attack is coded several different ways, by ICD-10 code or in the description text.

### 6. Tools, and what this course does with them

- **Looker**: Google's dashboarding platform; it is the hands-on visualization tool in this course. Tableau is not used, mainly because of licensing constraints (signing people up for accounts that may or may not be expired).
- **Weka**: a free tool used in a later course in the micro-certificate series, not this one.
- **Power BI / Tableau**: used "in some capacity" in the industry, depending on the team.
- **Where hospital data lives**: personal health information is not meant to travel around on a laptop, so you connect and work through a web browser, with all compute happening on a centralized hospital server. The instructor's analogy: Google Sheets is a spreadsheet that is not on your laptop; it is on a server. Sometimes the datasets are simply too big to fit on a laptop.
- **Databricks free edition**: perpetually free — no credits that expire after a month. Databricks is more Python-focused by default and does not have Power BI built in. Amazon gives a one-time $200 credit, but standing up cloud infrastructure is more data engineering than data science.
- **The course's goal**: give you the vocabulary to describe what is wrong with the dataset you are looking at, for the analysis you are trying to do. Once you can state the problem, AI tools (ChatGPT, Copilot) translate it into whatever tool you use — Weka, Looker, Power BI, Tableau, R, or Python — either as code or as button clicks. Without the words to name the problem, the tools cannot help you.
- **What comes next**: next week's office hours run longer — going through half of a published data paper, the first R code, with instructions for installing things or a browser-only option (no installation) for following along.

### 7. Preview: imaging, text, and machine learning

- **Images as data**: a computer reads an image as a sequence of zeros and ones. Images almost never get processed "as a picture": they are typically turned into black and white, and brightness and contrast are analyzed; an image can even be deliberately made blurry, because the computer does not need fine details. Around twenty different processing passes run at the same time, each looking for a different aspect of the image.
- **Scale limits**: with image work you can manage hundreds of images on your own machine, not thousands.
- **Supervised machine learning**: a clinician (for example an ophthalmologist) has already labeled a training set — "this is diabetic retinopathy at this severity" — and the model is then asked which bucket a new image fits into. Where a doctor's call and the model's call differ (for instance the model predicts a more severe case), that discrepancy can be a flag in a hospital system.
- **The Kaggle breast-cancer cautionary tale**: in one competition the goal was to hide the labels and test a model, but of two hundred mammogram images the first eighty all had cancer and the rest did not. The model simply learned "if the ID number is less than 80, it is a cancer image." The lesson: explore your data first — not every column is one you should feed to a model, and computers will latch onto shortcuts like that quickly.
- **Fitting is the easy part**: in code, fitting a model is short — pick a model (say, linear regression), fit it on the data, and you have your model. All of the real work is in whether you are giving it the right inputs.
- **Text analysis is not in this course**: classifying patient–caregiver message streams belongs to the machine-learning side. This course focuses on figures, plots, and distributions — understanding the data, and making sure it is clean and not massively biased, before any modeling.

## Questions

- **Q:** If there is an OLTP system and an OLAP system, would both be accessible through the same application — is the OLTP linked to the database and the OLAP to the data warehouse? How does that normally work?
  **A:** It varies by organization. Some departments require a data request through a ticket: a data team touches the transactional database, processes what you asked for, and hands you an Excel file or a dataset your analytics tool can hit — you never touch the transactional database. Other setups are one giant platform (for example Databricks or Snowflake) where some datasets are the transactional ones and some are the processed analytics ones, and you simply have permissions for one side or the other. Practically, if you are analyzing and you point at a dataset, it is almost certainly the analytics side, because you very rarely need the live hospital feed — "practically, it is all OLAP."
- **Q:** Does that mean the ETL piece is automated — is it a separate tool, or a series of scripts?
  **A:** It comes in as a series of scripts. Everything ends up on a database, data warehouse, or lake, and you talk to that through scripts, typically in SQL. Not every data question can be formulated directly in SQL; you often just pull the needed columns from the needed tables, and do the further processing later in your own tools.
- **Q:** I have come across the term "data lake" — is that the same as a data warehouse, and how does it relate to or differ from one?
  **A:** In his words, truly the same thing: one place for everything. Historically, data had to be rectangular like a spreadsheet; now data includes things like imaging — X-rays, and CT and MRI scans that are slices through the body, not flat photos. The warehouse metaphor is a house (structured), the lake metaphor is water (no structure): dump all of it in one place, then pull out the pieces you need. It solves the storage problem, but you still have to do the work to get data analytics-ready. Whole companies (Snowflake, Databricks) are built around storing all your data in one place and sticking an analytics tool on top.
- **Q:** Are we going to have access to Weka to build our own charts and visualizations, including for images and text?
  **A:** Weka is the next course in this series — it is not this course, and it is free. This course does have hands-on visualization with Looker, Google's dashboarding platform (not Tableau, because of licensing constraints). The more important skill is to see and identify what is wrong with the dataset you are looking at, for the analysis you are trying to do. If you can do that, everything else is a question to ChatGPT about how to do it in whatever tool you are using; if you cannot state your problem, the tools cannot help you.
- **Q:** Do hospitals use Power BI or Tableau?
  **A:** Yes, all of those tools get used in some capacity; it depends on the group you are in.
- **Q:** How many columns and rows does the 100k Synthea version have, and which version should I use to play with it?
  **A:** Start with the smallest (10k) version so your computer does not crash just to look at something; the columns are all going to be the same, 100k just has more rows. Some of these files are 2 GB CSVs.
- **Q:** Does the 100k dataset have relational tables — would that make it SQL?
  **A:** It comes to you as CSV, so to use SQL you would have to load it into a database first. It does arrive split into separate tables — allergies, conditions, devices, encounters, patients (and more), typically loaded in a database as separate tables, and you have to find the right keys and connect them together. That is why the CSV version is friendly: you can open it in Excel and work things like `VLOOKUP` to combine the pieces without setting up a database.
- **Q:** Are we going to go over imaging data — for example, visualizing how a disease like an eye disease grows or progresses over time?
  **A:** Image-related visualization gets touched on more in the next course, where machine learning begins. Dataset examples exist on Kaggle — an eye-image set (from a competition) and breast-cancer images — where the "dataset" is a folder of images the computer reads as zeros and ones. Image work usually requires a whole other image-processing program, and severity scoring (such as grading an eye disease) comes from the supervised-machine-learning idea: a doctor labels the training images, and the model predicts which bucket a new image fits in.
- **Q:** What about the text streams from our previous class — patient messages to care providers, classifying who is speaking and how severe things are? Are we covering that?
  **A:** That is not in this course; text analysis ends up in the machine-learning world. This course is about figures, plots, and distributions of your data, and making sure the data is clean, makes sense, and does not have a massive bias before you do any machine learning at all.
- **Q:** How would you do data cleaning for health data in general — handling duplication and formats, especially with images?
  **A:** Images almost never get processed "as is." They are typically turned to black and white, and brightness and contrast are analyzed; images have their own processing formats that a computer can easily turn into zeros and ones. Sometimes images are deliberately made blurry, because the computer does not need fine details, and around twenty different processing passes run at once, each looking for a different aspect of the image. Scale is the limit: hundreds of images is workable on your own machine, not thousands.

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: qwen3.8-27b-sglang (requested: qwen3.8-27b-sglang)
- backend: opencode
- inputs: transcript-plaud.md
- generated: 2026-10-23
