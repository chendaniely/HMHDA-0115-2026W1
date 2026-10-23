# Transactional vs. Analytical Data Systems (OLTP, OLAP and ETL)

Instructor: Daniel Chen

## Summary

This was the first office-hours session of the course. Daniel Chen, a data science instructor in the statistics department, explained how these Thursday sessions work. They are for questions about the week's homework and materials. On some weeks he will also do a short lecture on the coding side of the course. Next week will move into R code, with instructions for installing the software or for working entirely in a web browser. He also explained how he uses AI in the course. He records each session, publishes a text transcript with speakers labelled by number (no audio, so students' voices are not published), and uses an AI model to summarise it. He said he will ask students to create a GitHub.com account, with an announcement to follow.

The teaching part of the session reviewed this week's most confusing vocabulary: **online transaction processing (OLTP)** and **online analytical processing (OLAP)** systems, and the **extract, transform, load (ETL)** process that moves data between them. Transactional systems are built to capture data quickly and without errors, such as every encounter in a hospital. Analytical systems hold processed, summarised data for answering questions. You usually cannot tell which kind of system a dataset came from just by looking at it. In practice, almost any dataset an analyst touches lives on the analytics side, is a snapshot rather than a live feed, and has been through an ETL step. Daniel also covered data cubes, roll-ups and drill-downs. He explained why there is no such thing as a universally "analytics-ready" dataset: each question may need the data shaped differently.

Daniel introduced **Synthea** (whose site is now called SyntheticMass) as a free, synthetic, hospital-like dataset that students can explore in Excel. It is useful for practising on realistic messiness, such as defining heart attacks for a 30-day readmission question. The question period covered how analysts actually access data in a hospital, data lakes versus data warehouses, which tools are used in this course and the next, cloud options, and image and text data. It closed with a cautionary tale about a breast cancer model that learned patient ID numbers instead of cancer. That story is the reason this course focuses on exploring and visualising data before any modelling.

## Knowledge Points

### 1. Why data outgrows spreadsheets

- **Size limits**: Spreadsheet programs like Excel have a maximum number of rows and a maximum number of columns per sheet.
  - Coding languages also have limits, but much larger ones.
  - Part of the reason is that a spreadsheet must draw every cell on screen, which is costly. Code does not have to display the data, so it saves that compute.
- **NHS COVID example (2020)**: The UK's National Health Service added a new column every day for that day's COVID case counts.
  - Eventually the sheet ran out of columns, and historical data was silently lost instead of being stored.
  - Daniel was not sure of the exact column limit and suggested looking it up.
  - **Common mistake — lesson 1**: If you keep appending to a spreadsheet, you will eventually hit a limit. Be mindful of how much you are adding.
  - **Common mistake — lesson 2**: The data was stored in a poor format. Adding a new *column* per day is the wrong shape. Real data platforms are built with many more rows than columns.

### 2. OLTP vs. OLAP

- **Transactional system (OLTP, "T for transaction")**: Its main goal is to capture data quickly and without errors.
  - In hospitals, electronic health records are stored by **encounter** in a database.
  - That structure prioritises ease of financial reporting, which is not the same as being ready for health analytics.
  - **Everyday analogy**: Building a personal budget spreadsheet by copying entries from your credit card statement is a transactional activity, because you are simply recording transactions.
- **Analytical system (OLAP, "A for analytics")**: Holds data that has been processed and aggregated for answering questions.
  - This is the side analysts almost always work on.
- **You can't tell by looking**: A table where each row is one encounter or observation could come from either system. The distinction is about the *system* the data sits in, not the table itself.
  - Raw, unprocessed data typically comes from the transactional side.
- **Why the two are kept separate**: Data arrives in high volume and very quickly, since patients arrive every moment of the day.
  - Calculations and aggregations take time. They must not slow down or block the capture of new data.
  - Processing therefore runs in **batches** on an hourly, daily or weekly cadence.
- **Snapshots, not live data**: As a hospital analyst you usually get a snapshot, such as "as of last night" or "this morning". Live data needs special arrangements and is rarely required.
- **Even simple questions need processing**: Take "How many people came in during September?" Counting encounters is not enough. You must find the number of **unique people**, because one person can have many encounters as they move through the hospital and see different clinicians.
  - On huge data, even this can take seconds to compute.
  - Once you have a dataset of unique people per month, it is analytics-ready *for that question*, and you can simply sum it.

### 3. ETL (Extract, Transform, Load)

- **ETL**: You extract data from the transactional database, transform it into the shape your question needs, and load it into the analytics platform.
  - Some systems order the steps differently, for example ELT. Any permutation of the three letters exists.
- **No universal "analytics-ready" dataset**: Each question may need the data in a different format, so the transformation step varies with the question.
- **How ETL is done**: Usually through scripts, typically written in **SQL**, the language databases use.
  - Not every question can be answered in SQL alone.
  - A common pattern is to use SQL to pull just the columns and tables you need, then process the result further with other tools, such as R. This is why the office hours will show R code.

### 4. Data cubes, roll-ups and drill-downs

- **Data cube**: A way to picture aggregated data. Each variable you group or summarise by becomes an axis.
  - Example axes: month of year, unique people, and age (count, average, minimum, maximum).
  - People can only visualise three dimensions, but data can be cut into more groups. A flattened table is the cube in two dimensions.
  - Building one requires **filtering** (reducing the number of rows) and **grouping** by variables.
- **Drill-down**: Breaking the data into more, finer cuts, such as by month *and* age group.
- **Roll-up**: Aggregating into fewer groups, such as dropping the age breakdown and looking only at totals by month.

### 5. How analysts actually access hospital data

- **Data request teams**: In some organisations you submit a ticket to a data team.
  - The team works with the transactional database, processes the data, and returns it, for example as an Excel file or in a location your analytics tool can reach.
  - This also protects privacy, because the team controls which fields you can see. For example, you may not see the MRN or SIN, perhaps only initials.
- **Single platforms with permissions**: Platforms such as **Databricks** or **Snowflake** may hold both transactional and analytical datasets. Your permissions determine which you can reach.
- **Practical rule**: Unless you are the systems administrator, the dataset you are working with is almost certainly on the analytics (OLAP) side.
  - Sometimes the analytics copy is simply a delayed copy of the transactional data.
- **Privacy — data stays on the server**: In hospital systems, personal health information is generally **not** allowed onto your laptop.
  - You work with the data through a web browser, and all the compute runs on a central hospital server. This is similar to how a Google Sheet lives on a server rather than on your computer.
  - These datasets are also often too large to fit on a laptop.

### 6. Data warehouses vs. data lakes

- **Same idea, different metaphor**: In Daniel's view, they are essentially the same thing.
  - **Warehouse**: Houses are structured. This fits data that arrives as rectangles, like spreadsheets.
  - **Lake**: Lakes are made of water and have no structure, so you can "throw everything in". This fits non-rectangular data, such as X-rays, CT and MRI scans (images in slices through the body), and other medical device outputs.
- **What they solve**: The storage problem of getting all data into one place, instead of hunting through separate folders and making separate requests. They also try to make searching easier.
- **What they don't solve**: You still have to do substantial work to get data analytics-ready.
- Snowflake and Databricks are the two biggest companies built around this model: store all your data in one place, then put an analytics tool on top.

### 7. Synthea / SyntheticMass: practice data

- **What it is**: A synthetically generated dataset that mimics how hospital data looks and is stored. The site was renamed to SyntheticMass.
- **Download**: Use the "Download data" option. The **CSV** version is the most convenient because it opens in Excel or any spreadsheet program.
- **Structure**: The data comes as several separate tables, for example allergies, conditions, devices, encounters and patients.
  - **Patients** and **encounters** together tell you who came in, when, and their demographics.
  - This is the transactional layout. Each encounter row stores a patient identifier plus that encounter's details. Name, birthday and occupation sit once in another table, which reduces repetition and makes writing data faster.
  - Combining the tables in Excel would mean using something like `VLOOKUP`. In a database they would be separate tables joined with SQL.
- **Sizes**: The data comes in 10k and 100k versions. Some files are around 2 GB.
  - **Start with the smaller version** so your computer doesn't crash. The columns are the same in both; the larger version just has more rows.
- **FHIR**: Synthea also exports in FHIR, a standard format that hospital data is stored and exported in. Many tools can read it.
- **Example question — 30-day readmission after a heart attack (MI)**:
  - In the US, insurers won't reimburse a hospital if a patient returns within 30 days. Hospitals must balance keeping a patient in a bed longer against discharging them and risking readmission.
  - This is hard to answer because the data is spread across tables. A "heart attack" can be coded several ways, by an ICD-10 code or in a description field. Even "how many heart attacks today?" is more complicated than it looks.

### 8. Why this course focuses on exploring and visualising data

- **Vocabulary first**: The main goal is to give you the words to describe what is wrong with a dataset for your analysis.
  - Once you can describe the problem, an AI tool can tell you the code or button clicks for any tool: Weka, Looker, Power BI, Tableau, R or Python.
  - Without the vocabulary, these tools can't help you.
  - You still have to judge whether the output is good, bad, and makes sense.
- **Modelling code is easy; the input is the hard part**: Fitting a model, such as a linear regression, takes very little code. Almost all the work is making sure you give it the right input.
- **Warning — the breast cancer model that learned ID numbers**: In a Kaggle-style labelled mammogram dataset of about 200 images, the rows were sorted so that the first ~80 were all cancer.
  - The model learned "ID number below 80 means cancer".
  - Computers pick up patterns like this very quickly.
  - **Not every column you have should go into a model.** Explore your data first to check that it is clean, makes sense, and has no hidden bias.

### 9. Beyond tables: images and machine learning (preview of the next course)

- **Supervised machine learning**: A human expert, such as an ophthalmologist, has already labelled the training data (for example, "diabetic retinopathy at this severity"). The model learns to assign a new image to one of those labelled categories.
  - Disagreements between a clinician's label and the model's prediction can serve as flags in a hospital system.
- **Image data**: The computer reads an image as numbers.
  - Processing steps include converting to black and white, adjusting brightness and contrast, and deliberately blurring. Images are often processed many different ways in parallel.
  - This quickly outgrows a personal computer. Hundreds of images may be manageable; thousands usually are not.
- **Kaggle**: A source of datasets, including medical image sets such as eye disease and breast cancer.
- **Text analysis** of patient–provider communication is not covered in this course and may not be covered in the next. It belongs to machine learning.

## Questions

- **Q:** If there's an OLTP (the database) and an OLAP (the data warehouse), can an analyst access both through the same application?
  **A:** It depends on the organisation.
  - Sometimes you make a data request and a data team works with the transactional database for you, then hands back processed data. You never touch the transactional side, which also protects privacy.
  - Sometimes one platform, such as Databricks or Snowflake, holds both, and your permissions decide which you can reach.
  - In practice, any dataset you can access as a non-administrator is almost certainly on the analytics side.
- **Q:** Is the ETL step automated? Is it a separate tool or a series of scripts?
  **A:** Usually a series of scripts, typically in SQL, which talk to the database, warehouse or lake. Often SQL pulls the needed columns and tables, and you do further processing yourself in another tool. In hospital settings this all happens through a browser on a central server, not on your laptop.
- **Q:** Is a data lake the same as a data warehouse?
  **A:** Essentially yes. "Lake" emerged once data stopped being only rectangular, for example imaging. A lake is a place to dump all data in one location. It solves storage and tries to ease search, but you still have to do the work to make data analytics-ready.
- **Q:** Will we get access to Weka for making our own visualisations?
  **A:** Weka is used in the next course in the micro-certificate, not this one. It is free.
- **Q:** Do hospitals use Power BI or Tableau?
  **A:** Yes. All of these tools get used in some capacity, depending on the group you are in.
- **Q:** Is this course hands-on, or do we only analyse visuals we're given?
  **A:** There is hands-on work. You build visualisations in **Looker** (Google's dashboarding platform). Tableau isn't used because of licensing constraints. The concepts transfer between tools.
- **Q:** How many columns are in the 100k Synthea COVID dataset, and which size is best to play with?
  **A:** Probably not many columns. The columns are the same across sizes; the larger version just has more rows. Start with the smallest version so your computer doesn't crash.
- **Q:** Could we use the cloud instead, for example Amazon credits or Databricks Free Edition?
  **A:** You would need to find and set up your own cloud, which is closer to data engineering than data science. Daniel is trying, for the first time in this course, to set up a pre-configured cloud environment, but free compute is always limited. He likes the Databricks Free Edition because it is perpetually free with monthly usage limits. It is Python-focused by default and doesn't have Power BI built in.
- **Q:** Does the COVID 100k data have relational tables, so we'd use SQL?
  **A:** Yes. There are separate tables (allergies, conditions, devices, encounters, patients). To use SQL you would first have to load the CSVs into a database. The CSV version avoids setting up a database: you can open the files in Excel and combine them with something like `VLOOKUP`.
- **Q:** Will we cover visualising imaging data, such as a disease progressing over time?
  **A:** Image datasets exist, for example on Kaggle, where a dataset can just be a folder of images. That topic belongs more to the next course's machine learning content.
- **Q:** How is the severity of an eye disease measured from images?
  **A:** Through supervised machine learning. A specialist labels images by condition and severity, and a model learns to place new images into those categories.
- **Q:** Could a model reveal when the doctor made a labelling mistake?
  **A:** Differences between the clinician's label and the model's prediction (for example, the model rating a case as more severe) can act as flags in a hospital system.
- **Q:** Will we cover text analysis, such as classifying patient–provider messages?
  **A:** Not in this course, and possibly not in the next. That is machine learning territory. This course focuses on plots and distributions so you understand and trust your data before any modelling.
- **Q:** How do you clean health data, especially images?
  **A:** Images have their own processing tools, such as converting to black and white, adjusting brightness and contrast, and blurring. Everything ultimately has to become numbers for the computer. This becomes computationally heavy fast.

## Assignments

- [ ] Watch for the course announcement and create a GitHub.com account when asked. No due date was given.
- [ ] Optional: download the smaller (10k) CSV version of the Synthea / SyntheticMass dataset and explore its tables in Excel. Bring questions to office hours.

---

- prompt: prompt-notes.md @ c7623cc
- prompt-hash: c082a6eab694
- model: claude-opus-5-5 (requested: opus)
- backend: claude
- inputs: transcript-plaud.md
- generated: 2026-10-23
