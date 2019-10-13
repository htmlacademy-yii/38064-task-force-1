<?php

require_once 'src/Task.php';

$newTask = new Task(1, date_create('tomorrow'));
assert($newTask->getCurrentStatus() === Task::STATUSES['new'], new ErrorException('После создания задания, его статут должен быть - new'));

$newTask->cancel();
assert($newTask->getCurrentStatus() === Task::STATUSES['cancelled'], new ErrorException('После отмены задания заказчиком, статус задания должен быть - cancelled'));

$newTask = new Task(1, date_create('tomorrow'));
$newTask->start(2);
assert($newTask->getCurrentStatus() === Task::STATUSES['active'], new ErrorException('После старта задания заказчиком, статус задания должен быть - active'));

$newTask->refuse();
assert($newTask->getCurrentStatus() === Task::STATUSES['failed'], new ErrorException('После отказа исполнителем от задания, статус должен быть - failed'));

$newTask = new Task(1, date_create('tomorrow'));
$newTask->start(2);
$newTask->finish();
assert($newTask->getCurrentStatus() === Task::STATUSES['finished'], new ErrorException('После завершения задания заказчиком, статус должен быть - finished'));

echo 'Все работает корректно';
