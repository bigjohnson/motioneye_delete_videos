# motioneye_delete_videos
Delete archived motioneye videos if there is not available size.

You must run the script daily with cron, with a user that has write permission on motioneye video directory.

This script work better with a partition reserved only for motioneye videos, if other data fill the disk, the script continue to delete motioneye videos.
