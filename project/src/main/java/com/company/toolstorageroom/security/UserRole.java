package com.company.toolstorageroom.security;

import com.company.toolstorageroom.entity.*;
import io.jmix.security.model.EntityAttributePolicyAction;
import io.jmix.security.model.EntityPolicyAction;
import io.jmix.security.role.annotation.EntityAttributePolicy;
import io.jmix.security.role.annotation.EntityPolicy;
import io.jmix.security.role.annotation.ResourceRole;
import io.jmix.securityflowui.role.annotation.MenuPolicy;
import io.jmix.securityflowui.role.annotation.ViewPolicy;

@ResourceRole(name = "User", code = UserRole.CODE)
public interface UserRole {
    String CODE = "user";

    @MenuPolicy(menuIds = {"InventoryItem.list", "ItemHistory.list", "Manufacturer.list", "Provider.list", "Employees.list", "Warehouse.list", "Batch.list", "StorageCell.list"})
    @ViewPolicy(viewIds = {"InventoryItem.list", "ItemHistory.list", "Manufacturer.list", "Provider.list", "Employees.list", "Warehouse.list", "Batch.list", "StorageCell.list", "Batch.detail", "Employees.detail", "InventoryItem.detail", "LoginView", "MainView", "ItemHistory.detail", "Manufacturer.detail", "Provider.detail", "User.detail", "Warehouse.detail"})
    void screens();

    @EntityAttributePolicy(entityClass = Batch.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = Batch.class, actions = EntityPolicyAction.ALL)
    void batch();

    @EntityAttributePolicy(entityClass = Employees.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = Employees.class, actions = EntityPolicyAction.ALL)
    void employees();

    @EntityAttributePolicy(entityClass = InventoryItem.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = InventoryItem.class, actions = EntityPolicyAction.ALL)
    void inventoryItem();

    @EntityAttributePolicy(entityClass = Manufacturer.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = Manufacturer.class, actions = EntityPolicyAction.ALL)
    void manufacturer();

    @EntityAttributePolicy(entityClass = ItemHistory.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = ItemHistory.class, actions = EntityPolicyAction.ALL)
    void itemHistory();

    @EntityAttributePolicy(entityClass = Provider.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = Provider.class, actions = EntityPolicyAction.ALL)
    void provider();

    @EntityAttributePolicy(entityClass = StorageCell.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = StorageCell.class, actions = EntityPolicyAction.ALL)
    void storageCell();

    @EntityAttributePolicy(entityClass = User.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = User.class, actions = EntityPolicyAction.ALL)
    void user();

    @EntityAttributePolicy(entityClass = Warehouse.class, attributes = "*", action = EntityAttributePolicyAction.MODIFY)
    @EntityPolicy(entityClass = Warehouse.class, actions = EntityPolicyAction.ALL)
    void warehouse();
}