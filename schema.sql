-- Clinical Governance Agent: PPH Implementation Schema
-- Architect: Dr. Sharon Licqurish

CREATE TABLE clinicians (
    clinician_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) CHECK (role IN ('Obstetrician', 'Midwife', 'Anaesthetist', 'Junior Doctor')),
    is_on_call BOOLEAN DEFAULT TRUE
);

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    admission_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    risk_score_initial INT CHECK (risk_score_initial BETWEEN 1 AND 10),
    blood_type VARCHAR(5)
);

CREATE TABLE vitals_stream (
    log_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    systolic_bp INT NOT NULL,
    heart_rate INT NOT NULL,
    estimated_blood_loss_ml INT DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Clinical Safety Guard: Prevent impossible data entry
    CONSTRAINT physiological_bounds CHECK (systolic_bp > 0 AND heart_rate > 0)
);

CREATE TABLE agent_governance_logs (
    alert_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    clinician_id INT REFERENCES clinicians(clinician_id),
    action_taken TEXT NOT NULL,
    escalation_triggered BOOLEAN DEFAULT FALSE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
