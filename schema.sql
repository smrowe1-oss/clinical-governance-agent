/*
  PROJECT: Clinical Governance Agent - PPH Risk Mitigation
  AUTHOR: Dr. Sharon Licqurish
  VERSION: 1.0.0
  DESCRIPTION: A safety-critical relational schema designed to bridge the 
  Implementation Gap using SQL-driven governance and NPT coherence.
*/

-- 1. SECURITY & ACCESS CONTROL (Enterprise Standard)
-- Creating a restricted role for the AI Agent to prevent 'Hallucination' at the DB level.
CREATE ROLE clinical_agent_service;

-- 2. CORE PATIENT REGISTRY
CREATE TABLE patients (
    patient_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    mrn_encrypted TEXT NOT NULL, -- Privacy-First Approach
    admission_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    current_pph_risk_tier INT DEFAULT 1,
    CONSTRAINT risk_tier_range CHECK (current_pph_risk_tier BETWEEN 1 AND 5)
);

-- 3. PHYSIOLOGICAL TELEMETRY (The 'Sense' Layer)
CREATE TABLE vital_signs_stream (
    telemetry_id SERIAL PRIMARY KEY,
    patient_id UUID REFERENCES patients(patient_id),
    systolic_bp INT NOT NULL,
    diastolic_bp INT NOT NULL,
    estimated_blood_loss_ml INT DEFAULT 0,
    recorded_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    
    -- CLINICAL SAFETY GUARDS (Governance Constraints)
    -- This prevents the AI from reasoning over 'impossible' or 'noisy' data.
    CONSTRAINT bp_physiological_limit CHECK (systolic_bp BETWEEN 30 AND 280),
    CONSTRAINT blood_loss_safety_check CHECK (estimated_blood_loss_ml >= 0)
);

-- 4. AGENTIC DECISION LOG (The 'Reason' Layer)
-- This provides an Audit Trail for Clinical Governance.
CREATE TABLE agent_decisions (
    decision_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID REFERENCES patients(patient_id),
    npt_dimension_check TEXT, -- Coherence, Participation, etc.
    decision_rationale TEXT NOT NULL,
    action_triggered TEXT,
    is_clinician_overridden BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 5. PERFORMANCE VIEWS (The 'Audit' Layer)
-- A high-level view for senior clinicians/Board advisors.
CREATE VIEW clinical_risk_summary AS
SELECT 
    p.patient_id, 
    v.systolic_bp, 
    v.estimated_blood_loss_ml,
    d.action_triggered
FROM patients p
JOIN vital_signs_stream v ON p.patient_id = v.patient_id
LEFT JOIN agent_decisions d ON p.patient_id = d.patient_id;
