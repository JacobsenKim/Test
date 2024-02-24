
-- https://sqlitebrowser.org/
-- Load youre HA_DB file in DB Browser for SQLite
-- We also use this program to export the DB to .csv files, and later iport to the mariaDB.

-- Run to get list from youre DB

SELECT sql FROM sqlite_master;


#################################################
# Insert below in consol under homeassistant DB #
# My list as 2024-02-24                         #
#################################################

CREATE TABLE event_data (
	data_id INTEGER NOT NULL, 
	hash BIGINT, 
	shared_data TEXT, 
	PRIMARY KEY (data_id)
);
CREATE TABLE state_attributes (
	attributes_id INTEGER NOT NULL, 
	hash BIGINT, 
	shared_attrs TEXT, 
	PRIMARY KEY (attributes_id)
);
CREATE TABLE statistics_meta (
	id INTEGER NOT NULL, 
	statistic_id VARCHAR(255), 
	source VARCHAR(32), 
	unit_of_measurement VARCHAR(255), 
	has_mean BOOLEAN, 
	has_sum BOOLEAN, 
	name VARCHAR(255), 
	PRIMARY KEY (id)
);
CREATE TABLE recorder_runs (
	run_id INTEGER NOT NULL, 
	start DATETIME, 
	end DATETIME, 
	closed_incorrect BOOLEAN, 
	created DATETIME, 
	PRIMARY KEY (run_id)
);
CREATE TABLE schema_changes (
	change_id INTEGER NOT NULL, 
	schema_version INTEGER, 
	changed DATETIME, 
	PRIMARY KEY (change_id)
);
CREATE TABLE statistics_runs (
	run_id INTEGER NOT NULL, 
	start DATETIME, 
	PRIMARY KEY (run_id)
);
CREATE TABLE events (
	event_id INTEGER NOT NULL, 
	event_type VARCHAR(64), 
	event_data TEXT, 
	origin VARCHAR(32), 
	origin_idx SMALLINT, 
	time_fired DATETIME, 
	context_id VARCHAR(36), 
	context_user_id VARCHAR(36), 
	context_parent_id VARCHAR(36), 
	data_id INTEGER, time_fired_ts FLOAT, context_id_bin BLOB, context_user_id_bin BLOB, context_parent_id_bin BLOB, event_type_id INTEGER, 
	PRIMARY KEY (event_id), 
	FOREIGN KEY(data_id) REFERENCES event_data (data_id)
);
CREATE TABLE statistics (
	id INTEGER NOT NULL, 
	created DATETIME, 
	start DATETIME, 
	mean FLOAT, 
	min FLOAT, 
	max FLOAT, 
	last_reset DATETIME, 
	state FLOAT, 
	sum FLOAT, 
	metadata_id INTEGER, created_ts FLOAT, start_ts FLOAT, last_reset_ts FLOAT, 
	PRIMARY KEY (id), 
	FOREIGN KEY(metadata_id) REFERENCES statistics_meta (id) ON DELETE CASCADE
);
CREATE TABLE statistics_short_term (
	id INTEGER NOT NULL, 
	created DATETIME, 
	start DATETIME, 
	mean FLOAT, 
	min FLOAT, 
	max FLOAT, 
	last_reset DATETIME, 
	state FLOAT, 
	sum FLOAT, 
	metadata_id INTEGER, created_ts FLOAT, start_ts FLOAT, last_reset_ts FLOAT, 
	PRIMARY KEY (id), 
	FOREIGN KEY(metadata_id) REFERENCES statistics_meta (id) ON DELETE CASCADE
);
CREATE TABLE states (
	state_id INTEGER NOT NULL, 
	entity_id VARCHAR(255), 
	state VARCHAR(255), 
	attributes TEXT, 
	event_id INTEGER, 
	last_changed DATETIME, 
	last_updated DATETIME, 
	old_state_id INTEGER, 
	attributes_id INTEGER, 
	context_id VARCHAR(36), 
	context_user_id VARCHAR(36), 
	context_parent_id VARCHAR(36), 
	origin_idx SMALLINT, last_updated_ts FLOAT, last_changed_ts FLOAT, context_id_bin BLOB, context_user_id_bin BLOB, context_parent_id_bin BLOB, metadata_id INTEGER, 
	PRIMARY KEY (state_id), 
	FOREIGN KEY(event_id) REFERENCES events (event_id) ON DELETE CASCADE, 
	FOREIGN KEY(old_state_id) REFERENCES states (state_id), 
	FOREIGN KEY(attributes_id) REFERENCES state_attributes (attributes_id)
);
CREATE TABLE event_types (
	event_type_id INTEGER NOT NULL, 
	event_type VARCHAR(64), 
	PRIMARY KEY (event_type_id)
);
CREATE TABLE states_meta (
	metadata_id INTEGER NOT NULL, 
	entity_id VARCHAR(255), 
	PRIMARY KEY (metadata_id)
);
CREATE TABLE sqlite_stat1(tbl TEXT,idx TEXT,stat BLOB);
CREATE INDEX ix_event_data_hash ON event_data (hash);
CREATE INDEX ix_state_attributes_hash ON state_attributes (hash);
CREATE UNIQUE INDEX ix_statistics_meta_statistic_id ON statistics_meta (statistic_id);
CREATE INDEX ix_recorder_runs_start_end ON recorder_runs (start, end);
CREATE INDEX ix_statistics_runs_start ON statistics_runs (start);
CREATE INDEX ix_events_data_id ON events (data_id);
CREATE INDEX ix_states_old_state_id ON states (old_state_id);
CREATE INDEX ix_states_event_id ON states (event_id);
CREATE INDEX ix_states_attributes_id ON states (attributes_id);
CREATE INDEX ix_events_time_fired_ts ON events (time_fired_ts);
CREATE INDEX ix_states_last_updated_ts ON states (last_updated_ts);
CREATE INDEX ix_statistics_start_ts ON statistics (start_ts);
CREATE UNIQUE INDEX ix_statistics_statistic_id_start_ts ON statistics (metadata_id, start_ts);
CREATE INDEX ix_statistics_short_term_start_ts ON statistics_short_term (start_ts);
CREATE UNIQUE INDEX ix_statistics_short_term_statistic_id_start_ts ON statistics_short_term (metadata_id, start_ts);
CREATE UNIQUE INDEX ix_event_types_event_type ON event_types (event_type);
CREATE UNIQUE INDEX ix_states_meta_entity_id ON states_meta (entity_id);
CREATE INDEX ix_events_context_id_bin ON events (context_id_bin);
CREATE INDEX ix_states_context_id_bin ON states (context_id_bin);
CREATE INDEX ix_events_event_type_id_time_fired_ts ON events (event_type_id, time_fired_ts);
CREATE INDEX ix_states_metadata_id_last_updated_ts ON states (metadata_id, last_updated_ts);
