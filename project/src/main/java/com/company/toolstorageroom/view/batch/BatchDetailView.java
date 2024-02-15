package com.company.toolstorageroom.view.batch;

import com.company.toolstorageroom.entity.Batch;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "batches/:id", layout = MainView.class)
@ViewController("Batch.detail")
@ViewDescriptor("batch-detail-view.xml")
@EditedEntityContainer("batchDc")
public class BatchDetailView extends StandardDetailView<Batch> {
}