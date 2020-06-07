import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './Message.dart';

class Appointment {

  final String id;
  final String doctorId;
  final String userId;
  final List<Message> messages;
  final Timestamp time;
  final String channelId;
  final bool videoCallActive;
  final bool audioCallActive;

  const Appointment({
    @required this.id,
    @required this.doctorId,
    @required this.userId,
    this.messages,
    this.time,
    this.channelId,
    this.videoCallActive,
    this.audioCallActive,
  });

  factory Appointment.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    Appointment appointment = Appointment(
      id: snapshot.documentID ?? null,
      doctorId: data['doctorId'] ?? null,
      userId: data['userId'] ?? null,
      messages: data['messages'] ?? null,
      time: data['time'] ?? Timestamp.now(),
      channelId: data['channelId'] ?? null,
      videoCallActive: data['videoCallActive'] ?? false,
      audioCallActive: data['audioCallActive'] ?? false,
    );
    return appointment;
  }

}