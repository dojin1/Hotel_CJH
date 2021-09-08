package com.humanhotel.app;

public class Booked {
	private int bookcode;
	private int roomcode;
	private String roomname;
	private String roomtype;
	private int max_howmany;
	private int howmany;
	private int howmuch;
	private String checkin;
	private String checkout;
	private String booker;
	private String mobile;
	//생성자 두개 (기본생성자, 모든변수를 세팅하는 생성자)
	// getters/setters
	public Booked() { //기본생성자
	}
	
	public Booked(int bookcode, int roomcode, String roomname, String roomtype, int max_howmany, int howmany,
			int howmuch, String checkin, String checkout,  String booker, String mobile) {
		this.bookcode = bookcode;
		this.roomcode = roomcode;
		this.roomname = roomname;
		this.roomtype = roomtype;
		this.max_howmany = max_howmany;
		this.howmany = howmany;
		this.howmuch = howmuch;
		this.checkin = checkin;
		this.checkout = checkout;
		this.booker = booker;
		this.mobile = mobile;
	}
	
	public int getBookcode() {
		return bookcode;
	}
	public void setBookcode(int bookcode) {
		this.bookcode = bookcode;
	}
	public int getRoomcode() {
		return roomcode;
	}
	public void setRoomcode(int roomcode) {
		this.roomcode = roomcode;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public String getRoomtype() {
		return roomtype;
	}
	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}
	public int getMax_howmany() {
		return max_howmany;
	}
	public void setMax_howmany(int max_howmany) {
		this.max_howmany = max_howmany;
	}
	public int getHowmany() {
		return howmany;
	}
	public void setHowmany(int howmany) {
		this.howmany = howmany;
	}
	public int getHowmuch() {
		return howmuch;
	}
	public void setHowmuch(int howmuch) {
		this.howmuch = howmuch;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getBooker() {
		return booker;
	}
	public void setBooker(String booker) {
		this.booker = booker;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
}
