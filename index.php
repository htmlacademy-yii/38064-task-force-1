<?php
require_once 'vendor/autoload.php';

use Common\Task;
use Common\TaskAction;
use Common\TaskStatus;


$newTask = new Task(TaskStatus::NEW, date_timestamp_get(date_create('tomorrow')), 1);

assert($newTask->getNextStatus(TaskAction::ACCEPT) === TaskStatus::IN_PROGRESS,
    new ErrorException('У нового задания после принятия статус должен меняться на IN_PROGRESS'));

assert($newTask->getNextStatus(TaskAction::CANCEL) === TaskStatus::CANCELLED,
    new ErrorException('У нового задания после отмены статус должен меняться на CANCELLED'));


$newTask->accept(2);

assert($newTask->getNextStatus(TaskAction::COMPLETE) === TaskStatus::COMPLETED,
    new ErrorException('После завершения активного задания, его статус должен меняться на COMPLETED'));

assert($newTask->getNextStatus(TaskAction::REJECT) === TaskStatus::FAILED,
    new ErrorException('После отказа от активного задания, его статус должен меняться на FAILED'));


echo 'Все работает корректно';
