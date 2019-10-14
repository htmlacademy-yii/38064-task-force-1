<?php

//namespace src;

class Task {

    const ACTION_CANCEL = 1;
    const ACTION_START = 2;
    const ACTION_FINISH = 4;
    const ACTION_RESPOND = 8;
    const ACTION_REFUSE = 16;

    const STATUS_NEW = 0;
    const STATUS_ACTIVE = 1;
    const STATUS_FINISHED = 2;
    const STATUS_CANCELLED = 3;
    const STATUS_FAILED = 4;

    const ACTOR_CUSTOMER = 0;
    const ACTOR_CONTRACTOR = 1;

    private $customerId;
    private $contractorId;
    private $completionDate;
    private $status;

    private $availableStatuses = [];
    private $availableActions = [];

    public function __construct($customerId, $completionDate) {
        $this->customerId = $customerId;
        $this->completionDate = $completionDate;
        $this->status = self::STATUS_NEW;
    }

    public function getAvailableStatuses() {
        return $this->availableStatuses;
    }

    public function getAvailableActions() {
        return $this->availableActions;
    }

    public function getCurrentStatus() {
        return $this->status;
    }

    public function cancel() {
        $this->status = self::STATUS_CANCELLED;
    }

    public function start($contractorId) {
        $this->status = self::STATUS_ACTIVE;
        $this->contractorId = $contractorId;
    }

    public function finish() {
        $this->status = self::STATUS_FINISHED;
    }

    public function respond() {

    }

    public function refuse() {
        $this->status = self::STATUS_FAILED;
    }
}
