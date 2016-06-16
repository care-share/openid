--
-- Copyright 2016 The MITRE Corporation, All Rights Reserved.
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this work except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

--
-- Turn off autocommit and start a transaction so that we can use the temp tables
--

SET AUTOCOMMIT FALSE;

START TRANSACTION;

--
-- Insert user information into the temporary tables. To add users to the HSQL database, edit things here.
-- 

INSERT INTO users_TEMP (username, password, enabled) VALUES
  ('admin','vU@1aM0K',true),
  ('srobbins','h0T1&!4u',true),
  ('gmasters','13&czY4?',true),
  ('ssmith','xY13$80!',true),
  ('ejohnson','Mn48#&aM',true),
  ('mbender','Wx!2@RR4',true),
  ('jhowell','7@3bPq%1',true);


INSERT INTO authorities_TEMP (username, authority) VALUES
  ('admin','ROLE_ADMIN'),
  ('admin','ROLE_USER'),
  ('srobbins','ROLE_USER'),
  ('gmasters','ROLE_USER'),
  ('ssmith','ROLE_USER'),
  ('ejohnson','ROLE_USER'),
  ('mbender','ROLE_USER'),
  ('jhowell','ROLE_USER');
    
-- By default, the username column here has to match the username column in the users table, above
INSERT INTO user_info_TEMP (sub, preferred_username, name, email, email_verified) VALUES
  ('90342.ASDFJWFA','admin','Demo Admin','admin@example.com', true),
  ('12345.ABCDEFGH','srobbins','Sally Robbins','sallyrobbinstest9@gmail.com', true),
  ('23456.BCDEFGHI','gmasters','Greg Masters','gregmasterstest4@gmail.com', true),
  ('34567.CDEFGHIJ','ssmith','Steve Smith','stevesmithtest7@gmail.com', true),
  ('45678.DEFGHIJK','ejohnson','Elena Johnson','elenajohnsontest3@gmail.com', true),
  ('56789.EFGHIJKL','mbender','Matt Bender','mattbendertest42@gmail.com', true),
  ('67890.FGHIJKLM','jhowell','Jessica Howell','jessicahowelltest2@gmail.com', true);
 
--
-- Merge the temporary users safely into the database. This is a two-step process to keep users from being created on every startup with a persistent store.
--

MERGE INTO users 
  USING (SELECT username, password, enabled FROM users_TEMP) AS vals(username, password, enabled)
  ON vals.username = users.username
  WHEN NOT MATCHED THEN 
    INSERT (username, password, enabled) VALUES(vals.username, vals.password, vals.enabled);

MERGE INTO authorities 
  USING (SELECT username, authority FROM authorities_TEMP) AS vals(username, authority)
  ON vals.username = authorities.username AND vals.authority = authorities.authority
  WHEN NOT MATCHED THEN 
    INSERT (username,authority) values (vals.username, vals.authority);

MERGE INTO user_info 
  USING (SELECT sub, preferred_username, name, email, email_verified FROM user_info_TEMP) AS vals(sub, preferred_username, name, email, email_verified)
  ON vals.preferred_username = user_info.preferred_username
  WHEN NOT MATCHED THEN 
    INSERT (sub, preferred_username, name, email, email_verified) VALUES (vals.sub, vals.preferred_username, vals.name, vals.email, vals.email_verified);

    
-- 
-- Close the transaction and turn autocommit back on
-- 
    
COMMIT;

SET AUTOCOMMIT TRUE;

