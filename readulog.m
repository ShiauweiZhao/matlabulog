%% run open log file 
clear;
handles.current_fileName = 'xxxx';
handles.current_dir_PathName = 'xxxx';
[handles.current_fileName, handles.current_dir_PathName] = get_current_logfile_popup(handles);
file_path=[handles.current_dir_PathName,handles.current_fileName,'.ulg'];

ulog = ulogreader(file_path);
msg = readTopicMsgs(ulog);
d1 = ulog.StartTime;
d2 = d1 + duration([1 2 55],'Format','hh:mm:ss.SSSSSS');
systeminfo = readSystemInformation(ulog);
params = readParameters(ulog);
loggedoutput = readLoggedOutput(ulog);
log = readLoggedOutput(ulog,'Time',[d1 d2]);

%% 获取tuc时间
d_s= d1 + duration([0 1 55],'Format','hh:mm:ss.SSSSSS');
dance_utc = readTopicMsgs(ulog,'TopicNames',{'dance_utc_log'}, 'InstanceID',{0},'Time',[d_s d2]);
utc_log = dance_utc.TopicMessages{1,1};
figure;
plot(utc_log.timestamp,utc_log.pps_time_utc_usec,'o');hold on;
plot(utc_log.timestamp,utc_log.gps_time_utc_usec,'*');
legend('pps time','gps time');
grid;
title('pps校准时间对比');
%% dance log 
dance_log = readTopicMsgs(ulog,'TopicNames',{'dance_step_log'}, 'InstanceID',{0},'Time',[d1 d2]);
dance_position = dance_log.TopicMessages{1,1};

dance_step_position = readTopicMsgs(ulog,'TopicNames',{'dance_step_position'}, 'InstanceID',{0},'Time',[d1 d2]);
dance_position_receive = dance_step_position.TopicMessages{1,1};
figure;
subplot(3,1,1);
plot(dance_position_receive.timestamp,dance_position_receive.step_cnt);
legend('receive dance step');
grid;
title('接收航点cnt');
subplot(3,1,2);
plot(dance_position.timestamp,dance_position.step_cnt);
legend('send dance step');
grid;
title('舞步发送cnt');
subplot(3,1,3);
plot(dance_position.timestamp,dance_position.unused_fifo_size);
legend('unused_fifo_size');
grid;
title('fifo使用情况');
%% 获取姿态角
vehicle_attitude_data = readTopicMsgs(ulog,'TopicNames',{'vehicle_attitude'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 vehicle_attitude = vehicle_attitude_data.TopicMessages{1,1};
 %% 获取遥控器各通道控制量
 input_rc_data = readTopicMsgs(ulog,'TopicNames',{'input_rc'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 
 %% 磁数据对比
 mag0_data =  readTopicMsgs(ulog,'TopicNames',{'sensor_mag'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
mag1_data =  readTopicMsgs(ulog,'TopicNames',{'sensor_mag'}, ... 
 'InstanceID',{1},'Time',[d1 d2]);
 
 %% 各通道控制量
 actuator_controls =  readTopicMsgs(ulog,'TopicNames',{'actuator_controls'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 
 %% 各电机控制量
 actuator_outputs = readTopicMsgs(ulog,'TopicNames',{'actuator_outputs'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 
 %% 原始传感器数据
 sensor_combined= readTopicMsgs(ulog,'TopicNames',{'sensor_combined'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 
 %% 陀螺仪零偏估计 
 sensor_gyro = readTopicMsgs(ulog,'TopicNames',{'sensor_gyro'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 %% 传感器融合结果 
 vehicle_gps_position = readTopicMsgs(ulog,'TopicNames',{'vehicle_gps_position'}, ... 
 'InstanceID',{0},'Time',[d1 d2]);
 %% 姿态融合结果对比 
 
 %% 高度融合结果
 
 %% gps定位模式确认
 
 %% 水平速度和姿态对比 
 
 %% 轨迹跟踪结果
 
 %% 位置跟踪结果
 
 %% 速度跟踪结果 
 
 %% 姿态跟踪结果
 vehicle
 