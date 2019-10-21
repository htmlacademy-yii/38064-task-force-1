<?php

//namespace src;

class Task
{
    /** @var int */
    private $customerId;

    /** @var int */
    private $contractorId;

    /** @var int */
    private $deadline;

    /** @var int */
    private $status;

    private $lifecycleMap = [
        TaskStatus::NEW => [
            TaskAction::ACCEPT => TaskStatus::IN_PROGRESS,
            TaskAction::CANCEL => TaskStatus::CANCELLED,
        ],
        TaskStatus::IN_PROGRESS => [
            TaskAction::COMPLETE => TaskStatus::COMPLETED,
            TaskAction::REJECT => TaskStatus::FAILED,
        ],
    ];

    public function __construct(int $status, int $deadline, int $customerId, int $contractorId = null)
    {
        $this->status = $status;
        $this->deadline = $deadline;
        $this->customerId = $customerId;
        $this->contractorId = $contractorId;
    }

    public function getNextStatus(int $action): int
    {
        return $this->lifecycleMap[$this->status][$action] ?? null;
    }

    public function accept(int $contractorId): void
    {
        $this->contractorId = $contractorId;
        $this->status = TaskStatus::IN_PROGRESS;
    }

    //    public function getCurrentStatus()
    //    {
    //        return $this->status;
    //    }
    //
    //    public function cancel()
    //    {
    //        $this->status = self::STATUS_CANCELLED;
    //    }
    //
    //    public function finish()
    //    {
    //        $this->status = self::STATUS_FINISHED;
    //    }
    //
    //    public function respond()
    //    {
    //
    //    }
    //
    //    public function refuse()
    //    {
    //        $this->status = self::STATUS_FAILED;
    //    }
}
