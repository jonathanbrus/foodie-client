import 'package:flutter/material.dart';

List<Step> requestedSteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order confirmed"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Order Packed"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Out for delivery"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Delivered"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
];

List<Step> confirmedSteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order confirmed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order Packed"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Out for delivery"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Delivered"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
];

List<Step> packedSteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order confirmed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order Packed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Out for delivery"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
  const Step(
    title: Text("Delivered"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
];

List<Step> deliverySteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order confirmed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order Packed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Out for delivery"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Delivered"),
    content: Text("Your order request was sent successfully."),
    isActive: false,
    state: StepState.disabled,
  ),
];

List<Step> deliveredSteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order confirmed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order Packed"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Out for delivery"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Delivered"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
];

List<Step> canceledSteps = [
  const Step(
    title: Text("Request Sent"),
    content: Text("Your order request was sent successfully."),
    isActive: true,
    state: StepState.complete,
  ),
  const Step(
    title: Text("Order canceled"),
    content: Text("Your order is canceled."),
    isActive: true,
    state: StepState.error,
  ),
];
