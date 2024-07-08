package com.yhs.portfolio.model;

public class Order extends Product {
	private int orderId;
	private int uId;
	private int quantity;
	private String date;

	public Order(int orderId, int uId, int quantity, String date) {
		super();
		this.orderId = orderId;
		this.uId = uId;
		this.quantity = quantity;
		this.date = date;
	}

	public Order() {

	}

	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", uId=" + uId + ", quantity=" + quantity + ", date=" + date + "]";
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getuId() {
		return uId;
	}

	public void setuId(int uId) {
		this.uId = uId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
