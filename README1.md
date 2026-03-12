# 🏥 Clinical Governance Agent: PPH Implementation Architecture
**Bridging the gap between health research portfolios and bedside Agentic AI.**

## 📌 Project Vision
In high-stakes clinical environments like the birthing suite, traditional predictive models often suffer from an **Implementation Gap**. A risk score on a dashboard is a "static insight"—it doesn't account for cognitive load, staff availability, or protocol drift. 

This repository demonstrates a **System-Level Architecture** for an Agentic AI Assistant designed to manage Postpartum Hemorrhage (PPH). It moves beyond prediction into **Active Governance**: sensing clinical data, reasoning through protocol constraints, and initiating micro-governance actions.

---

## 🏗️ The Three-Layer Architecture

### **1. The Sensory Layer (SQL-Driven)**
Built on a PostgreSQL backbone, this layer ensures absolute relational integrity. It tracks maternal vitals and fluid loss in real-time, utilizing composite keys to maintain a longitudinal record of patient safety.

### **2. The Reasoning Layer (Agentic Logic)**
Utilizing **Normalization Process Theory (NPT)**, the Agent doesn't just look at the patient; it evaluates the **clinical context**. It cross-references patient risk with live data on staff ratios and resource availability (e.g., blood bank proximity).

### **3. The Action Layer (Safety Protocols)**
The system is designed for **Agency**. When safety thresholds are breached, the Agent triggers "Micro-Governance" events:
* **Automated Escalation:** Instant notification to senior clinical leads.
* **Pre-emptive Resource Allocation:** Automated blood bank alerts and fluid prep.
* **Dynamic Checklists:** Real-time "Digital Partogram" updates for the bedside team to prevent protocol omission.

---

## 🛠️ Technical Implementation
* **Database Engine:** PostgreSQL
* **Core Technical Features:**
    * **Relational Integrity:** Strict foreign key constraints linking clinicians, patients, and interventions.
    * **Clinical Safety Guards:** Custom `CHECK` constraints to prevent erroneous data entry (e.g., physiological impossibilities).
    * **Governance Audit Trail:** Every Agent-initiated decision is logged in a `governance_audit` table for reflexive monitoring and post-event debriefing.

---

## 📂 Repository Structure
* `/database/schema.sql`: The foundational SQL architecture.
* `/docs/implementation_logic.md`: A deep dive into applying NPT to Agentic AI design.

---

## 📓 Researcher's Note
> "As a Senior Strategist, I view code as a governance tool. This architecture is designed to reduce the cognitive burden on frontline staff by automating the 'administrative' layer of crisis management, allowing clinicians to focus on the patient." 
> — **Dr. Sharon Licqurish**
