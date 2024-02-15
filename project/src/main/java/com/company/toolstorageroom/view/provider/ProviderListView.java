package com.company.toolstorageroom.view.provider;

import com.company.toolstorageroom.entity.Provider;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "providers", layout = MainView.class)
@ViewController("Provider.list")
@ViewDescriptor("provider-list-view.xml")
@LookupComponent("providersDataGrid")
@DialogMode(width = "64em")
public class ProviderListView extends StandardListView<Provider> {
}