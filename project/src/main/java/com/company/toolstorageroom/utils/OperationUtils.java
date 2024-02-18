package com.company.toolstorageroom.utils;

import com.company.toolstorageroom.entity.Operation;
import com.company.toolstorageroom.entity.Status;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class OperationUtils {
    private static final Map<Operation, Status> operationToStatus = new HashMap<>();
    private static final Map<Status, Operation> statusToOperation = new HashMap<>();

    static {
        operationToStatus.put(Operation.PLACE_ON_STOCK,Status.PLACE_ON_STOCK);
        operationToStatus.put(Operation.ISSUE_TO_USER,Status.ISSUE_TO_USER);
        operationToStatus.put(Operation.START_USE,Status.START_USE);
        operationToStatus.put(Operation.SEND_FOR_SHARPENING,Status.SEND_FOR_SHARPENING);
        operationToStatus.put(Operation.SEND_FOR_REPAIR,Status.SEND_FOR_REPAIR);
        operationToStatus.put(Operation.MARK_AS_FAULTY,Status.MARK_AS_FAULTY);
        operationToStatus.put(Operation.RESERVE,Status.RESERVE);
        operationToStatus.put(Operation.STORE_ON_STOCK,Status.STORE_ON_STOCK);
        operationToStatus.put(Operation.INSPECT,Status.INSPECT);
        operationToStatus.put(Operation.RETURN,Status.RETURN);
        operationToStatus.put(Operation.DISPOSE,Status.DISPOSE);
        operationToStatus.put(Operation.MARK_AS_LOST,Status.MARK_AS_LOST);
        operationToStatus.put(Operation.WRITE_OFF,Status.WRITE_OFF);
        operationToStatus.put(Operation.MOVE,Status.MOVE);

        statusToOperation.put(Status.PLACE_ON_STOCK,Operation.PLACE_ON_STOCK);
        statusToOperation.put(Status.ISSUE_TO_USER,Operation.ISSUE_TO_USER);
        statusToOperation.put(Status.START_USE,Operation.START_USE);
        statusToOperation.put(Status.SEND_FOR_SHARPENING,Operation.SEND_FOR_SHARPENING);
        statusToOperation.put(Status.SEND_FOR_REPAIR,Operation.SEND_FOR_REPAIR);
        statusToOperation.put(Status.MARK_AS_FAULTY,Operation.MARK_AS_FAULTY);
        statusToOperation.put(Status.RESERVE,Operation.RESERVE);
        statusToOperation.put(Status.STORE_ON_STOCK,Operation.STORE_ON_STOCK);
        statusToOperation.put(Status.INSPECT,Operation.INSPECT);
        statusToOperation.put(Status.RETURN,Operation.RETURN);
        statusToOperation.put(Status.DISPOSE,Operation.DISPOSE);
        statusToOperation.put(Status.MARK_AS_LOST,Operation.MARK_AS_LOST);
        statusToOperation.put(Status.WRITE_OFF,Operation.WRITE_OFF);
        statusToOperation.put(Status.MOVE,Operation.MOVE);
    }

    public Operation getOperation(Status status) {
        return statusToOperation.get(status);
    }

    public Status getStatus(Operation operation) {
        return operationToStatus.get(operation);
    }
}
