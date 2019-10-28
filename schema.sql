CREATE DATABASE IF NOT EXISTS `task_force_db`
    DEFAULT CHARACTER SET 'utf8'
    DEFAULT COLLATE 'utf8_general_ci';

USE task_force_db;

CREATE TABLE IF NOT EXISTS users
(
    user_id         INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    email           VARCHAR(130) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    name            VARCHAR(255) NOT NULL,
    avatar          VARCHAR(255),
    address         VARCHAR(255),
    birth_date      DATE,
    rating          DECIMAL(2, 1),
    bio             TEXT,
    phone           VARCHAR(20),
    skype           VARCHAR(255),
    any_messenger   VARCHAR(255),
    online_datetime DATETIME,
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS profiles
(
    user_id                  INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    notify_new_message       BOOL DEFAULT TRUE,
    notify_task_action       BOOL DEFAULT TRUE,
    notify_new_feedback      BOOL DEFAULT TRUE,
    visibility_only_customer BOOL DEFAULT FALSE,
    visibility_hidden        BOOL DEFAULT FALSE,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS works_photos
(
    photo_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    url VARCHAR(255) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (photo_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categories
(
    category_id MEDIUMINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    title       VARCHAR(255)       NOT NULL UNIQUE,
    icon        VARCHAR(255)       NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS cities
(
    city_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    title   VARCHAR(200) NOT NULL UNIQUE,
    PRIMARY KEY (city_id)
);

CREATE TABLE IF NOT EXISTS tasks
(
    task_id           INT UNSIGNED       NOT NULL UNIQUE AUTO_INCREMENT,
    title             VARCHAR(255)       NOT NULL,
    description       TEXT               NOT NULL,
    category_id       MEDIUMINT UNSIGNED NOT NULL,
    budget            MEDIUMINT UNSIGNED          DEFAULT NULL,
    status            TINYINT UNSIGNED   NOT NULL DEFAULT 0,
    customer_id       INT UNSIGNED       NOT NULL,
    contractor_id     INT UNSIGNED                DEFAULT NULL,
    rating            DECIMAL(2, 1)               DEFAULT NULL,
    creation_datetime DATETIME           NOT NULL,
    deadline          DATETIME                    DEFAULT NULL,
    city_id           INT UNSIGNED                DEFAULT NULL,
    lat               DECIMAL(10, 6)              DEFAULT NULL,
    lng               DECIMAL(10, 6)              DEFAULT NULL,
    PRIMARY KEY (task_id),
    FOREIGN KEY (category_id) REFERENCES categories (category_id),
    FOREIGN KEY (customer_id) REFERENCES users (user_id),
    FOREIGN KEY (contractor_id) REFERENCES users (user_id),
    FOREIGN KEY (city_id) REFERENCES cities (city_id)
);

CREATE TABLE IF NOT EXISTS files
(
    file_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    url     VARCHAR(255) NOT NULL,
    task_id INT UNSIGNED,
    PRIMARY KEY (file_id),
    FOREIGN KEY (task_id) REFERENCES tasks (task_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS specializations
(
    user_id     INT UNSIGNED       NOT NULL,
    category_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT specialization_pk
        PRIMARY KEY (user_id, category_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS messages
(
    message_id BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    text       TEXT            NOT NULL,
    datetime   DATETIME        NOT NULL,
    task_id    INT UNSIGNED    NOT NULL,
    sender_id  INT UNSIGNED    NOT NULL,
    PRIMARY KEY (message_id),
    FOREIGN KEY (task_id) REFERENCES tasks (task_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users (user_id)
);

CREATE TABLE IF NOT EXISTS responses
(
    response_id       BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    text              TEXT            NOT NULL,
    bid               INT UNSIGNED    NOT NULL,
    creation_datetime DATETIME        NOT NULL,
    task_id           INT UNSIGNED    NOT NULL,
    user_id           INT UNSIGNED    NOT NULL,
    PRIMARY KEY (response_id),
    FOREIGN KEY (task_id) REFERENCES tasks (task_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS feedback
(
    feedback_id   INT UNSIGNED     NOT NULL UNIQUE AUTO_INCREMENT,
    rating        TINYINT UNSIGNED NOT NULL,
    text          TEXT             NOT NULL,
    customer_id   INT UNSIGNED     NOT NULL,
    contractor_id INT UNSIGNED     NOT NULL,
    task_id       INT UNSIGNED     NOT NULL,
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (customer_id) REFERENCES users (user_id),
    FOREIGN KEY (contractor_id) REFERENCES users (user_id) ON DELETE CASCADE
);
