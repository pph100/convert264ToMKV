#!/bin/bash

CONVERT=~hicam/convert_264_to_mkv
FFMPEG=/opt/bin/ffmpeg
MKVMERGE=/opt/bin/mkvmerge

x=$(ps -auxww | egrep `basename $0` | egrep -v grep | head -1 | awk '{print $2;}')
curdir=$(cd $(dirname $0); pwd)
olddir=$(pwd)

echo "$(date): pwd: $(pwd) / curdir: $curdir"
cd $curdir
echo "$(date): pwd: $(pwd) / curdir: $curdir"

if [ $# -eq 0 ] ; then
	Files="${curdir}/*.264"
	echo "$(date) setting Files to *.264..."
else
	Files="$@"
	cd ${olddir}
	echo "$(date) chdir into ${olddir}; setting Files to Parameter $@..."
fi

if [ $(echo $Files | wc -w ) -eq 1 ] ; then
### f=$(echo cam1/*/record/*.264); x=$(echo $f | wc -w); if [ $x -gt 2 ] ; then echo "multiple"; else echo "single"; fi
	echo "$(date) no files found under parameter '" $Files "'" ", setting Files to ~hicam/store/cam*/[date]/record/*.264 ..."
	Files=$(echo ~hicam/store/cam*/$(date '+%Y%m%d')/record/*.264 2>/dev/null)
fi

echo "$(date) starting processing in PWD=$(pwd)..."
echo "$(date) processing $(echo $Files | wc -w) files..."

for f in $Files; do
	if [ ! -f "${f}" ] ; then
		echo "$(date) error: file ${f} does not exist. exit."
		break;
	fi
	if [ -r "${f}" ] ; then
		echo "$(date) starting processing for file ${f}..."
		DIR=$(dirname $f)
		BASE=$(basename $f .264)
		BASEN="${DIR}/${BASE}"
		WAV="${BASEN}.wav"
		MP3="${BASEN}.mp3"
		MKV="${BASEN}.mkv"
		H264="${BASEN}.h264"

		if [ -f "${MKV}" ] ; then
			echo "$(date) warning: file ${f} seems to have been converted already (${BASE}.mkv exists), skipping..."
		else
			echo "$(date) starting conversion of input file $f..."
			$CONVERT "$f"
			echo "=========================="
			echo "$(date) convert job done."
			echo "=========================="
			$FFMPEG -i "${WAV}" "${MP3}"
			echo "$(date) ffmpeg job done."
			echo "=========================="
			$MKVMERGE --output "${MKV}" --timestamps "0:${BASEN}.video.ts.txt" "${H264}" "${MP3}" 
			echo "$(date) mkvmerge job done."
			echo "=========================="
			echo "$(date) created output ${MKV} out of input ${f}"
			/bin/rm -f "${WAV}" "${MP3}" "${H264}" "${BASEN}.video.ts.txt" "${BASEN}.audio.ts.txt"
			echo "$(date) removed temporary files"
			echo ""; echo ""; echo ""
		fi
	else
		echo "$(date) warning: file ${f} is not readable. skipping..."
	fi
	echo ""
	echo ""
	echo ""
done

echo "$(date) end of processing..."
