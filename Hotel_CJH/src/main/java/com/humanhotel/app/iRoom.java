package com.humanhotel.app;

import java.util.ArrayList;

public interface iRoom {
	ArrayList<Roominfo> getRoomList();
	ArrayList<Roomtype> getRoomType();
	ArrayList<Booked> doFindBooker(String checkin,String checkout);
	ArrayList<Booked> doFindAbleBooker(String checkin,String checkout);
	void doDeleteRoom(int roomcode);
	void doDeleteBook(int bookcode);
	void doAddRoom(String roomname,int roomtype,int howmany, int howmuch);
	void doUpdateRoom(int roomcode,String roomname,int roomtype,int howmany, int howmuch);
	void doUpdateBook(int bookcode, int howmany, String booker, String mobile);
	void doSignin(String name, String loginid, int passcode);
	int doCheckUser(String userid, String userpw);
	void doReserve(int roomcode, int howmany, String checkin, String checkout, int total, String booker, String mobile);
}
