#! /usr/bin/env ruby

require 'bindata'

class AxpCurve < BinData::Record
    endian :little
    string :name, :read_length => 64
    string :src,  :read_length => 64
    string :idname, :read_length => 64
    string :unit, :read_length => 0x1c
    int16  :pointbydepth
    uint16 :valuetype
    string :reserved1, :read_length => 8
    float  :timeinterval
    float  :timedelay
    int16  :pointframe
    int16  :arraycount
    int32  :bytesum
    string :reciever, :read_length => 24
    string :sender, :read_length => 24
    float  :rrdistance
    float  :srdistance
    string :description, :read_length => 0x80
    string :reserved2, :read_length => 0x4c
    SIZE = 508
end
