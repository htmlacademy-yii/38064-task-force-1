<?php


class TaskAction
{
    const ACCEPT = 1;
    const CANCEL = 2;
    const COMPLETE = 4;
    const REJECT = 8;

    const ACTION_LIST = [
        self::ACCEPT => 'Принять',
        self::CANCEL => 'Отменить',
        self::COMPLETE => 'Завершить',
        self::REJECT => 'Отказаться',
    ];

    public static function getActionList()
    {
        return self::ACTION_LIST;
    }
}
