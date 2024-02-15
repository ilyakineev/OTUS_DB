package com.company.toolstorageroom.view.batch;

import com.company.toolstorageroom.entity.Batch;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "batches", layout = MainView.class)
@ViewController("Batch.list")
@ViewDescriptor("batch-list-view.xml")
@LookupComponent("batchesDataGrid")
@DialogMode(width = "64em")
public class BatchListView extends StandardListView<Batch> {
}