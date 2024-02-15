package com.company.toolstorageroom.view.itemhistory;

import com.company.toolstorageroom.entity.ItemHistory;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "itemHistories/:id", layout = MainView.class)
@ViewController("ItemHistory.detail")
@ViewDescriptor("item-history-detail-view.xml")
@EditedEntityContainer("itemHistoryDc")
public class ItemHistoryDetailView extends StandardDetailView<ItemHistory> {
}