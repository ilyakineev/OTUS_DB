package com.company.toolstorageroom.view.employees;

import com.company.toolstorageroom.entity.Employees;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "employeeses/:id", layout = MainView.class)
@ViewController("Employees.detail")
@ViewDescriptor("employees-detail-view.xml")
@EditedEntityContainer("employeesDc")
public class EmployeesDetailView extends StandardDetailView<Employees> {
}