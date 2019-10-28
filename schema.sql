CREATE DATABASE IF NOT EXISTS `task_force_db`
    DEFAULT CHARACTER SET 'utf8'
    DEFAULT COLLATE 'utf8_general_ci';

USE task_force_db;

CREATE TABLE IF NOT EXISTS users
(
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email         VARCHAR(130) NOT NULL UNIQUE,
    password      VARCHAR(255) NOT NULL,
    name          VARCHAR(255) NOT NULL,
    avatar        VARCHAR(255),
    address       VARCHAR(255),
    birth_date    DATE,
    bio           TEXT,
    phone         VARCHAR(20),
    skype         VARCHAR(255),
    any_messenger VARCHAR(255),
    date_visited  DATETIME,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS profiles
(
    user_id                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    notify_new_message       BOOL DEFAULT TRUE,
    notify_task_action       BOOL DEFAULT TRUE,
    notify_new_feedback      BOOL DEFAULT TRUE,
    visibility_only_customer BOOL DEFAULT FALSE,
    visibility_hidden        BOOL DEFAULT FALSE,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS portfolio_photos
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    url     VARCHAR(255) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS statuses
(
    id    TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(40)      NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS categories
(
    id    MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255)       NOT NULL UNIQUE,
    icon  VARCHAR(255)       NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cities
(
    id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tasks
(
    id            INT UNSIGNED       NOT NULL AUTO_INCREMENT,
    title         VARCHAR(255)       NOT NULL,
    description   TEXT               NOT NULL,
    category_id   MEDIUMINT UNSIGNED NOT NULL,
    budget        MEDIUMINT UNSIGNED          DEFAULT NULL,
    status_id     TINYINT UNSIGNED   NOT NULL DEFAULT 0,
    customer_id   INT UNSIGNED       NOT NULL,
    contractor_id INT UNSIGNED                DEFAULT NULL,
    date_create   DATETIME           NOT NULL,
    deadline      DATETIME                    DEFAULT NULL,
    city_id       INT UNSIGNED                DEFAULT NULL,
    lat           DECIMAL(10, 6)              DEFAULT NULL,
    lon           DECIMAL(10, 6)              DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (status_id) REFERENCES statuses (id) ON DELETE RESTRICT,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT,
    FOREIGN KEY (customer_id) REFERENCES users (id),
    FOREIGN KEY (contractor_id) REFERENCES users (id),
    FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS files
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    url     VARCHAR(255) NOT NULL,
    task_id INT UNSIGNED,
    PRIMARY KEY (id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS specializations
(
    user_id     INT UNSIGNED       NOT NULL,
    category_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT specialization_pk
        PRIMARY KEY (user_id, category_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS messages
(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    text        TEXT            NOT NULL,
    date_create DATETIME        NOT NULL,
    task_id     INT UNSIGNED    NOT NULL,
    sender_id   INT UNSIGNED    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS responses
(
    id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    text        TEXT            NOT NULL,
    bid         INT UNSIGNED    NOT NULL,
    date_create DATETIME        NOT NULL,
    task_id     INT UNSIGNED    NOT NULL,
    user_id     INT UNSIGNED    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS feedback
(
    id            INT UNSIGNED                   NOT NULL AUTO_INCREMENT,
    rating        ENUM ('1', '2', '3', '4', '5') NOT NULL,
    text          TEXT                           NOT NULL,
    customer_id   INT UNSIGNED                   NOT NULL,
    contractor_id INT UNSIGNED                   NOT NULL,
    task_id       INT UNSIGNED                   NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES users (id),
    FOREIGN KEY (contractor_id) REFERENCES users (id) ON DELETE CASCADE
);
