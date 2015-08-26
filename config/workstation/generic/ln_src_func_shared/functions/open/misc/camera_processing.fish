function camera_processing -d "sorts & resizes assets from digital camera"
# for now, don't use a universal processing directory
# retain the flexibility to change to an arbitrary directory
#···············································································

    set PWD_CACHE (pwd)

    __timestamper
    set TOP_DIR cam_proc_batch\_"$TIMESTAMP_UNIX"
    mkdir -v $TOP_DIR

#···············································································

    find . -name "*" | grep ".AVI" > /dev/null
    set -l FIND_AVI_STATUS $status
    if test $FIND_AVI_STATUS -eq 0
        mkdir -v $TOP_DIR/video
        mv -v *.AVI $TOP_DIR/video/
        mv -v *.THM $TOP_DIR/video/
    else
        __cli_message "No videos found"
    end # END VIDEO TEST

#···············································································

    find . -name "*" | grep ".JPG" > /dev/null
    set -l FIND_JPG_STATUS $status
    if test $FIND_JPG_STATUS -eq 0
        mkdir -v $TOP_DIR/images_original
        mkdir -v $TOP_DIR/images_resized
        mv -v *.JPG $TOP_DIR/images_original/

        cd $TOP_DIR/images_original
        __cli_message "Resizing images ..."
        for f in *.JPG
            set WIDTH (identify -ping -format '%W' $f)
            set HEIGHT (identify -ping -format '%H' $f)
            if [ $WIDTH -gt 2700 -o $HEIGHT -gt 2700 ]
                echo "Resizing $f"
                # -strip -unsharp 0,1.5,0.05 -modulate 100,130,100 -contrast
                convert -quality 100 +dither -resize 28% $f ../images_resized/$f
            else
                set_color red
                echo "Image $f appears to have already been resized (width=$WIDTH & height=$HEIGHT)"
                set_color normal
            end # END TEST FOR IMAGES ALREADY RESIZED
        end # END RESIZING LOOP

        cd ../images_resized
        __cli_message "Renaming resized files ..."
        if [ $HOST_OS = "arch_linux" ]
            # note: Arch ships the util-linux version of rename
            rename -v .JPG .rsz.jpg *.JPG
            __cli_div_80
            la
        else if [ $HOST_OS = "ubuntu_linux" ]
            rename -v 's/\.JPG$/\.rsz.jpg/' *.JPG
            __cli_div_80
            la
        else
            echo "rename failed"
        end # END OS TEST

    else
        __cli_message "No photos found"
    end # END PHOTO TEST

#···············································································

    # cd to cached directory
    cd $PWD_CACHE

end # END FUNCTION DEFINITION
