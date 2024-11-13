package com.air.dao;

public class PastdbDTO {

	// SO2 값
	private double So2;
	// CO 값
	private double Co;
	// O3 값
	private double O3;
	// NO3 값
	private double No2;
	// PM10 값
	private double Pm10;
	// PM2.5 값
	private double Pm25;
	// 지역
	private String Area;
	// 년도
	private int Year;
	// 월
	private int Month;
	
	public double getSo2() {
		return So2;
	}
	public void setSo2(double so2) {
		So2 = so2;
	}
	
	public double getCo() {
		return Co;
	}
	public void setCo(double co) {
		Co = co;
	}
	
	public double getO3() {
		return O3;
	}
	public void setO3(double o3) {
		O3 = o3;
	}
	
	public double getNo2() {
		return No2;
	}
	public void setNo2(double no2) {
		No2 = no2;
	}
	
	public double getPm10() {
		return Pm10;
	}
	public void setPm10(double pm10) {
		Pm10 = pm10;
	}
	
	public double getPm25() {
		return Pm25;
	}
	public void setPm25(double pm25) {
		Pm25 = pm25;
	}
	
	public String getArea() {
		return Area;
	}
	public void setArea(String area) {
		Area = area;
	}
	
	public int getYear() {
		return Year;
	}
	public void setYear(int year) {
		Year = year;
	}
	
	public int getMonth() {
		return Month;
	}
	public void setMonth(int month) {
		Month = month;
	}
	@Override
	public String toString() {
		return "PastdbDTO [So2=" + So2 + ", Co=" + Co + ", O3=" + O3 + ", No2=" + No2 + ", Pm10=" + Pm10 + ", Pm25="
				+ Pm25 + ", Area=" + Area + ", Year=" + Year + ", Month=" + Month + "]";
	}
	
	
	
	
}
