<?php

//namespace src;

class Task {

    const ACTIONS = [
        'cancel' => 0,
        'start' => 1,
        'finish' => 2,
        'respond' => 3,
        'refuse' => 4,
    ];

    const STATUSES = [
        'new' => 0,
        'active' => 1,
        'finished' => 2,
        'cancelled' => 3,
        'failed' => 4,
    ];

    const ACTORS = [
        'customer' => 0,
        'contractor' => 1,
    ];

    private $customerId;
    private $contractorId;
    private $completionDate;
    private $status;

    private $availableStatuses = [];
    private $availableActions = [];

    public function __construct($customerId, $completionDate) {
        $this->customerId = $customerId;
        $this->completionDate = $completionDate;
        $this->status = self::STATUSES['new'];
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
        $this->status = self::STATUSES['cancelled'];
    }

    public function start($contractorId) {
        $this->status = self::STATUSES['active'];
        $this->contractorId = $contractorId;
    }

    public function finish() {
        $this->status = self::STATUSES['finished'];
    }

    public function respond() {

    }

    public function refuse() {
        $this->status = self::STATUSES['failed'];
    }
}
