module Axpfile
    public
    def readtoarray(a, len)
        count = 0
        a.clear
        while not self.eof? and count < len
            a << self.readbyte
            count += 1
        end
        return count
    end
    def readbigint(s=0, len)
        ss = ''
        len.times do |i|
            ss << self[s+i].to_s(2)
        end
        return ss.to_i(2)
    end
    File.method "readtoarray"
    Array.method "readbigint"
    class Axpcurve
        attr_accessor :name
        attr_accessor :src
        attr_accessor :idname
        attr_accessor :unit
        attr_accessor :pointbydepth
        attr_accessor :valuetype
        attr_accessor :reserved1
        attr_accessor :timeinter
        attr_accessor :timedelay
        attr_accessor :pointframe
        attr_accessor :arraycount
        attr_accessor :bytesum
        attr_accessor :reciever
        attr_accessor :sender
        attr_accessor :rrdistance
        attr_accessor :srdistance
        attr_accessor :description
        attr_accessor :reserved2
    end

    class Fileaxp
        attr_accessor :mfile
        attr_accessor :mdata
        attr_accessor :mcurvehead
        attr_accessor :mcurvecount
        attr_accessor :mdepth
        attr_accessor :mtime
        attr_accessor :mfstep
        attr_accessor :mbdir
        attr_accessor :msotnum
        def initialize()
            mdata = nil
            mcurvecount = 0
        end
        def save(str)
            false
        end
        def open(str)
            res = File.exist?(str)
            if not res
                return false
            end
            begin
                mfile = File.new(str, "r")
                len = File.size? mfile
                index = 0
                while index < len
                    indication = Array.new 16
                    indicatcount = mfile.readtoarray(indication, 16)
                    index += 16
                    if indicatcount < 16
                        res = false
                    end
                    indi = indication[8]
                    blocklen = indication[0]
                    if (0x40 == indi)
                        pdata = Array.new(blocklen-16)
                        count = mfile.readtoarray(pdata, blocklen-16)
                        index += count
                        readcurvehead(pdata, count)
                    else
                    if (0x00 == indi)
                        pdata = Array.new(blocklen-16)
                        count =mfile.readtoarray(pdata, blocklen-16)
                        index += count
                        readcurvedata(pdata, count)
                    else
                    if (0x80 == indi) or
                       (0x22 == indi) or
                       (0xf0 == indi) or
                       (0xea == indi) or
                       (0xe8 == indi) or
                       (0xf1 == indi) or
                       (0xf2 == indi) or
                       (0xf3 == indi) or
                       (0xe9 == indi) or
                       (0xee == indi)
                       mfile.seek(blocklen-16, SEEK_CUR)
                       index += blocklen - 16
                    else
                        mfile.close
                        return false
                    end
                    if not res
                        return false
                    end
                    mfile.close
                    return true
                end
            rescue => err
                puts "Exception:#{err}"
                return false
            end
                
        end
        def getcurvecount()
        end
        def getcurvehead(index)
        end
        def getpointcount(curve_index)
        end
        def getcurvedata(curve_index, point_index)
        end
        def getpointbytecount(curve_index)
        end
        def getpointperdepth(curve_index)
        end
        def getdepth(pos)
        end
        def getbasesamplespace()
        end
        def getdirection()
        end
        def printfile()
        end
        def Fileaxp::readcurvehead(pdata, count)
            index = 0x2e
            dir = pdata[5]
            mbdir = (dir==5? false: true)
            # Float length is 4
            mfstep = mbdir? pdata.slice(0x10, 4): pdata.slice(0x0c, 4)
            msotnum = pdata[3]*256 + pdata[4]
            # unsigned int length is 4
            if pdata.slice(0x28, 4) == 0x42
                index = 0x2e
            end
            if pdata.slice(0x2c, 4) == 0x42
                index = 0x32
            end
            if pdata.slice(0x30, 4) == 0x42
                index = 0x36
            end
            len = 0
            si  = 0
            while count - index > 0
                len = pdata[index-2]
                if len != 0x0204
                    len = 0
                end
                curvehead = Axpcurve.new
                curvehead.name = pdata[index]
                curvehead.src = pdata[index+1]
                curvehead.idname = pdata[index+2]
                curvehead.unit = pdata[index+3]
                curvehead.valuetype = pdata[index+4]
                curvehead.reserved1 = pdata[index+5]
                curvehead.timeinter = pdata[index+6]
                curvehead.timedelay = pdata[index+7]
                curvehead.pointframe= pdata[index+8]
                curvehead.arraycount= pdata[index+9]
                curvehead.bytesum   = pdata[index+10]
                curvehead.reciever  = pdata[index+11]
                curvehead.sender    = pdata[index+12]
                curvehead.rrdistance= pdata[index+13]
                curvehead.srdistance= pdata[index+14]
                curvehead.description = pdata[index+15]
        end
        def readcurvedata(data, count)
        end
        def printdata(curve_index)
        end
    end
end
