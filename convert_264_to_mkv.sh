#!/bin/bash

CONVERT=convert_264_to_mkv
FFMPEG=ffmpeg
MKVMERGE=mkvmerge

if [ $# -eq 0 ] ; then
	Files="$(pwd)/*264"
else
	Files="$@"
fi

echo "$(date) starting processing..."

for f in "$Files"; do
	if [ ! -f "${f}" ] ; then
		echo "$(date) error: file ${f} does not exist. exit."
		break;
	fi
	if [ -r "${f}" ] ; then
		echo "$(date) starting conversion of input file $f..."
		DIR=$(dirname $f)
		BASE=$(basename $f .264)
		BASEN="${DIR}/${BASE}"
		WAV="${BASEN}.wav"
		MP3="${BASEN}.mp3"
		MKV="${BASEN}.mkv"
		H264="${BASEN}.h264"

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
		echo ""
		echo ""
		echo ""
	else
		echo "$(date) warning: file ${f} is not readable. skipped."
	fi
done

echo "$(date) end of processing..."
