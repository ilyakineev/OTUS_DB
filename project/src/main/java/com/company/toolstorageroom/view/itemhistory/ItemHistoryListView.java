package com.company.toolstorageroom.view.itemhistory;

import com.company.toolstorageroom.entity.ItemHistory;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "itemHistories", layout = MainView.class)
@ViewController("ItemHistory.list")
@ViewDescriptor("item-history-list-view.xml")
@LookupComponent("itemHistoriesDataGrid")
@DialogMode(width = "64em")
public class ItemHistoryListView extends StandardListView<ItemHistory> {
}