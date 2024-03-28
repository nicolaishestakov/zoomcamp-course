import pandas as pd
import argparse
from time import time
import os

import repo_commits as rc
import repo_snapshot as rs

def main(params):
    #params.commit_hash

    repo_dir = os.environ['REPO_DIR']

    print (f'Repo dir: {repo_dir}')

    commits = rc.retrieve_commit_history(repo_dir)

    df = pd.DataFrame(commits)
    dir = os.environ['SNAPSHOTS_DIR']

    print (f'Out dir: {dir}')

    df.to_csv(os.path.join(dir, 'commit_history.csv'))

    rs.make_snapshot(repo_dir, '', dir, ['.cs'])
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Starting up repo container')

    parser.add_argument('--commit', help='commit hash to write initial snapshot')
    
    args = parser.parse_args()


    main(args)