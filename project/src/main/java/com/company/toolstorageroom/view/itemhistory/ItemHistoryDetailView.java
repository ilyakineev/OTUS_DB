package com.company.toolstorageroom.view.itemhistory;

import com.company.toolstorageroom.entity.InventoryItem;
import com.company.toolstorageroom.entity.ItemHistory;

import com.company.toolstorageroom.utils.OperationUtils;
import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.component.ClickEvent;
import com.vaadin.flow.router.Route;
import io.jmix.core.DataManager;
import io.jmix.core.EntityStates;
import io.jmix.core.LoadContext;
import io.jmix.core.SaveContext;
import io.jmix.flowui.kit.component.button.JmixButton;
import io.jmix.flowui.model.DataContext;
import io.jmix.flowui.model.InstanceContainer;
import io.jmix.flowui.view.*;
import org.springframework.beans.factory.annotation.Autowired;

import javax.sql.DataSource;

@Route(value = "itemHistories/:id", layout = MainView.class)
@ViewController("ItemHistory.detail")
@ViewDescriptor("item-history-detail-view.xml")
@EditedEntityContainer("itemHistoryDc")
public class ItemHistoryDetailView extends StandardDetailView<ItemHistory> {

    @Autowired
    private OperationUtils operationUtils;
    @Autowired
    private DataManager dataManager;

    @Autowired
    private EntityStates entityStates;

    @Subscribe("saveAndCloseBtn")
    public void onSaveAndCloseBtnClick(final ClickEvent<JmixButton> event) {
        ItemHistory itemHistory = getEditedEntity();

        InventoryItem item = itemHistory.getInventoryitem();
        item.setStatus(operationUtils.getStatus(itemHistory.getOperation()));

        dataManager.save(item);
    }
}