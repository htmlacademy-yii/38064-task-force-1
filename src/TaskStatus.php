<?php

namespace Common;

class TaskStatus
{
    const NEW = 0;
    const IN_PROGRESS = 1;
    const COMPLETED = 2;
    const CANCELLED = 3;
    const FAILED = 4;

    const STATUS_LIST = [
        self::NEW => 'Новое',
        self::IN_PROGRESS => 'Активное',
        self::COMPLETED => 'Завершено',
        self::CANCELLED => 'Отменено',
        self::FAILED => 'Провалено',
    ];

    public function getStatusList()
    {
        return self::STATUS_LIST;
    }
}
