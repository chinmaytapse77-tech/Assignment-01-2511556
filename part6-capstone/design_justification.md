# Capstone — Part 6

## Storage Systems

The hospital's four goals each require a different storage system, chosen based on the nature of the data and the type of queries involved.

**Goal 1 — Predict patient readmission risk:** A **Data Warehouse** (star schema with fact and dimension tables) is used to store historical treatment data, discharge records, and patient outcomes. The warehouse is optimized for analytical queries that aggregate data across thousands of patients over time — exactly what a machine learning model needs to identify readmission patterns. The ML model (e.g. a gradient boosting classifier) is trained on this historical data and produces a risk score for each patient at discharge.

**Goal 2 — Plain English patient queries:** A **Vector Database** (e.g. Pinecone or ChromaDB) stores embeddings of patient history documents — past diagnoses, treatment notes, lab results. When a doctor asks "Has this patient had a cardiac event before?", the query is converted to an embedding and matched against stored vectors using cosine similarity. The top matching records are retrieved and passed to an LLM (Retrieval-Augmented Generation pipeline) which generates a structured natural language answer. The underlying patient records themselves are stored in **MySQL** (RDBMS), which serves as the source of truth for structured patient data.

**Goal 3 — Monthly management reports:** The same **Data Warehouse** used for Goal 1 serves this purpose as well, with additional dimension tables for departments, beds, and cost centres. A BI tool (Power BI or Tableau) connects directly to the warehouse and generates monthly dashboards for hospital management covering bed occupancy rates, department-wise costs, and staff utilization.

**Goal 4 — Real-time ICU vitals:** A **Time-Series Database** (InfluxDB) is used to store the continuous stream of ICU monitor data — heart rate, blood pressure, SpO2, temperature. InfluxDB is purpose-built for high-frequency time-stamped data and supports fast range queries like "show heart rate for patient X in the last 10 minutes". Apache Kafka handles the real-time ingestion from ICU devices before writing to InfluxDB.

---

## OLTP vs OLAP Boundary

The transactional system (OLTP) consists of the **MySQL RDBMS**, which handles day-to-day hospital operations — registering patients, recording prescriptions, scheduling appointments, and updating treatment notes. These are write-heavy, row-level operations that require ACID compliance to ensure data integrity.

The analytical system (OLAP) begins at the **ETL pipeline** (Apache Spark), which extracts data from MySQL on a scheduled basis (nightly or weekly), transforms and cleans it, and loads it into the Data Warehouse. From this point onwards — the warehouse, the ML model, the BI dashboards — all systems are read-heavy and optimized for aggregation and analysis rather than real-time updates. The boundary is therefore the ETL layer, which separates live operational data from historical analytical data.

---

## Trade-offs

The most significant trade-off in this design is **data freshness versus query performance** in the Data Warehouse. Because the ETL pipeline runs on a batch schedule (e.g. nightly), the warehouse data is always slightly out of date. A readmission risk prediction made at 9am is based on data that may be 8 hours old. For most reporting purposes this is acceptable, but for clinical decisions it could be a limitation.

To mitigate this, the design could introduce a **Lambda Architecture** approach — running a fast real-time layer (using Kafka Streams or Apache Flink) alongside the batch warehouse, so that the ML model can incorporate both historical patterns and the most recent patient data. Alternatively, the ETL frequency could be increased to hourly during peak hours. The trade-off is increased infrastructure cost and complexity, which would need to be weighed against the clinical benefit of more up-to-date predictions.
