DROP SCHEMA PUBLIC CASCADE;
CREATE SCHEMA PUBLIC;

CREATE SEQUENCE img_id_seq;
CREATE SEQUENCE person_id_seq;
CREATE SEQUENCE detection_id_seq;
CREATE SEQUENCE grouping_id_seq;
CREATE SEQUENCE face_id_seq;

CREATE TYPE detection_type AS ENUM (
    'normal',
    'oneface'
);

CREATE TYPE gender AS ENUM (
    'male',
    'female'
);

CREATE TYPE race as ENUM (
    'asian',
    'black',
    'white'
);

CREATE TABLE img (
    id BIGINT DEFAULT nextval('img_id_seq') NOT NULL PRIMARY KEY,

    -- optional url passed in via the image.
    source_url TEXT,

    -- url of the image on our servers.
    hosted_url TEXT NOT NULL,

    -- optional a string to be associated w/ the faces, which could later be retrieved via /info/get_face.
    tag VARCHAR(255),

    content BYTEA NOT NULL,
    extension TEXT NOT NULL,

    width INT NOT NULL,
    height INT NOT NULL,

    lat NUMERIC(10, 6) DEFAULT NULL,
    lng NUMERIC(10, 6) DEFAULT NULL,

    attributes JSONB DEFAULT '[]'::jsonb,
    meta JSONB DEFAULT '[]'::jsonb
);

CREATE TABLE person (
    id BIGINT DEFAULT nextval('person_id_seq') NOT NULL PRIMARY KEY,

    tag TEXT,
    first_name TEXT,
    middle_name TEXT,
    last_name TEXT,
    alternate_name TEXT,

    grouping_ids JSONB NOT NULL DEFAULT '[]'::jsonb
);

CREATE TABLE face (
    id BIGINT DEFAULT nextval('face_id_seq') NOT NULL PRIMARY KEY,
    person_id BIGINT
);


CREATE TABLE grouping (
    id BIGINT DEFAULT nextval('grouping_id_seq') NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);


CREATE TABLE detection (
    id BIGINT DEFAULT nextval('detection_id_seq') NOT NULL PRIMARY KEY, 
    img_id BIGINT NOT NULL REFERENCES img(id),
    face_id BIGINT NOT NULL REFERENCES face(id),
    
    center_x NUMERIC NOT NULL,
    center_y NUMERIC NOT NULL,

    nose_x NUMERIC NOT NULL,
    nose_y NUMERIC NOT NULL,

    eye_left_x NUMERIC NOT NULL,
    eye_left_y NUMERIC NOT NULL,

    eye_right_x NUMERIC NOT NULL,
    eye_right_y NUMERIC NOT NULL,

    mouth_left_x NUMERIC NOT NULL,
    mouth_left_y NUMERIC NOT NULL,

    mouth_right_x NUMERIC NOT NULL,
    mouth_right_y NUMERIC NOT NULL,

    attributes JSONB DEFAULT '[]'::jsonb,

    gender TEXT NOT NULL,
    gender_confidence NUMERIC NOT NULL,

    age NUMERIC NOT NULL,
    race NUMERIC NOT NULL,
    smiling NUMERIC NOT NULL,
    glass NUMERIC NOT NULL,

    pose_pitch_angle NUMERIC NOT NULL,
    pose_roll_angle NUMERIC NOT NULL,
    pose_yaw_angle NUMERIC NOT NULL
);


