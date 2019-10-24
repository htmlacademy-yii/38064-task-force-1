<?php

namespace Common;

class Task
{
    /** @var int */
    private $customerId;

    /** @var int |null */
    private $contractorId;

    /** @var int | null */
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

    public function __construct(int $status, int $customerId, int $contractorId = null, int $deadline = null)
    {
        $this->status = $status;
        $this->customerId = $customerId;
        $this->contractorId = $contractorId;
        $this->deadline = $deadline;
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
}
