![Screenshot](screen.png)

# GOAL

Create a VR framework with Godot Engine. 

## Tasks

+ To Make VR
    - Find how to access accelerator axis 
    - know how gyro-sensor works 
    - gyro-sensor and accleratometer is packaged in a chip (WOW)
    - How do I convert the raw values into quaternion? 
+ Some Spices 
    - Make Education resource not only for fun but for my job
    - Check due-diligence before forking this project 

# What I have learned

+ The distance of human eye is around 62mm
+ Acceleration is detected through Inertial Measurement Unit(IMU) 
    - [Intertial measurement unit](https://en.wikipedia.org/wiki/Inertial_measurement_unit)
+ Acceleration is measured as change in capacitance. Through D-Sigma ADC unit.
    - What is D-S ADC? How does it work?
    - How the angular velocity is measured?
+ I need to know how to convert Euler angle onto single quaternion
    - This can be simple but what is the best way?

# Note

とりあえず、デバッグ中は並行視で確認する

+ ステレオグラムの見方はWikipediaを参照のこと-> [ステレオグラム](https://ja.wikipedia.org/wiki/%E3%82%B9%E3%83%86%E3%83%AC%E3%82%AA%E3%82%B0%E3%83%A9%E3%83%A0)
