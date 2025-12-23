-- MySQL 8.x schema for agrarian_db
CREATE DATABASE IF NOT EXISTS agrarian_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE agrarian_db;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  full_name VARCHAR(255) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_types (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(64) NOT NULL UNIQUE,
  label VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_levels (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(64) NOT NULL UNIQUE,
  label VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS subjects (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(64) NOT NULL UNIQUE,
  label VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_user_types (
  user_id BIGINT UNSIGNED NOT NULL,
  type_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, type_id),
  CONSTRAINT fk_uut_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_uut_type FOREIGN KEY (type_id) REFERENCES user_types(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_user_levels (
  user_id BIGINT UNSIGNED NOT NULL,
  level_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, level_id),
  CONSTRAINT fk_uul_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_uul_level FOREIGN KEY (level_id) REFERENCES user_levels(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_subjects (
  user_id BIGINT UNSIGNED NOT NULL,
  subject_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, subject_id),
  CONSTRAINT fk_us_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_us_subject FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO user_types (code,label) VALUES
('admin','Administrator'),('teacher','Teacher'),('student','Student')
ON DUPLICATE KEY UPDATE code=code;

INSERT INTO user_levels (code,label) VALUES
('lvl1','Level 1'),('lvl2','Level 2'),('lvl3','Level 3')
ON DUPLICATE KEY UPDATE code=code;

INSERT INTO subjects (code,label) VALUES
('math','Mathematics'),('sci','Science'),('eng','English'),('hist','History')
ON DUPLICATE KEY UPDATE code=code;
