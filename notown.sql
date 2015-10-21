drop table songs;
drop sequence song_seq;
drop table instruments;
drop sequence instr_seq;

CREATE TABLE songs
(
	song_id number not null,
	title varchar2(127) not null,
	author varchar2(127) not null,
	CONSTRAINT song_pk PRIMARY KEY (song_id)
);

CREATE SEQUENCE song_seq;

CREATE OR REPLACE TRIGGER song_inc
BEFORE INSERT ON songs
FOR EACH ROW

BEGIN
  SELECT song_seq.NEXTVAL
  INTO :new.song_id
  FROM dual;
END;
/
CREATE TABLE instruments
(
	instr_id NUMBER NOT NULL,
	instr_name VARCHAR2(32) NOT NULL,
	instr_key VARCHAR2(8) NOT NULL,
	CONSTRAINT instr_pk PRIMARY KEY (instr_id)
);

CREATE SEQUENCE instr_seq;

CREATE OR REPLACE TRIGGER instr_inc
BEFORE INSERT ON instruments
FOR EACH ROW

BEGIN
  SELECT instr_seq.NEXTVAL
  INTO :new.instr_id
  FROM dual;
END;
/
